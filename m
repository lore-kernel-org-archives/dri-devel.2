Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A8606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bqLwpgrC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C1A10EB04;
	Mon, 19 Oct 2026 19:48:20 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295FF10EB04
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 19:48:13 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c445c95d553so161564466b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792439291; x=1793044091;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tmwGNNCW2d+wdPNQw8vyggjKJN0vflWnyQoTqa3ZJcU=;
 b=bqLwpgrCZrXeFec8+QlE4FVKwseGLj/K9ls8gOzd4Uvtew/Pp7P2KpfEq2Yd4cGz8l
 2hPIKjnFF5+3eH+BH5u65uXSrUbwJrinCJHrbkyiIAXCnBSwnkMJ4z5axZGbeBW0spEd
 GO4N0XnFHydBHjBvqtLnEFQMlSyr9IvsIsWws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792439291; x=1793044091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tmwGNNCW2d+wdPNQw8vyggjKJN0vflWnyQoTqa3ZJcU=;
 b=ZeLa5peqs1xFjzO3LZFWVcGccqkabRSSeEyukEh1hB95rMMB8Cp0Iuv//cHuMM0wrx
 I4seAf8cbJ2oRsZ91hjuTHioGP+AjK2biapfS+0lLmRhzCUOsagfKR3ndqrmFoGgeI/i
 NRBw8PQz5Hj6UTsYePfAHhUbaDiFNO4SeosB0sdgbrTFLNMMH6utbVLknJVnJ/SIVMMP
 oq/DiNaYBTdURcmtQtqtzbSduBVIVfv/PzycWsCjtQYjGbVkWtYv5N8tz214GztSkF0e
 cD2OTDPcR9twyFvIaIPvMMhGuR+tqJavN7BG+Kqvua7vrX2x/iORh3gzAcSlerAO7LH1
 pmvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznhkHg0GulVuIHvM2MquxH8LNEugGJjZvPmuFXMc50dMc52PLnjCV5swKHQZUCNqUVvxKQC+pqrW4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIABbPOc1fWlr0s59zIjhmu/v98FBW5hClc+3M0PpDGdjtyEoA
 nnJbMsmtuWJfsqtYQBc3t0Aht3J9Y7a/qSP28UuOiiYYDEDpAj/+icejKBqIOL+8+3oeOxDObNJ
 jBFLp0g==
X-Gm-Gg: AYBFou1xQgEVaCtjd8j+1OFBJ7aJHXfr9FtDm0vPAtWCsdrRsDc2hMqt7nMNLbxlJsE
 dgwfkZp0lKQ6/YGAuSaWcy5rahnjrzixgE8Vz1+UoGpnO1aBpx2i2F9Jx1RaIuraRoA58zKSXl+
 MMHiIeYmKTQ5pLzdiiP9Cqqg1Ap792w6ZNitBODwUtRjy5WnGYsivVqHASTGBOWRJsr7ssJMiaP
 G8Xt71Pra4wuotolKlv8b6cMsMQDcc5In0wUZ02ANOHKTAFLwW7dsgMg4kW8X/1EoXteOzJH2jO
 B9iu1NQFoUQbGKsaZ7aAJTJQ9wGvwESi8/UBv1vVw6uz9241h9BcbwKnav/zX3kxt/p1VDCgWBc
 tnxu7Zcu9rb6bmj1xjVOqxCYc0bMTRLW8nS9vTk+fWlQoVzZxsg9hVuVpKIgGC82nkrdtfC8lPz
 vCQaUGOU50vPqJQxihsyrUEOMTOrSzlDXb6zmZzDTB7E52Jh+ovylprUckmS3ZgkjANV7uV6Wqf
 S3t7XE73wC7Gl07mTrT6b3C7uJLM+XTnsg6ShSpG6mexAsfyi6TlH3EEom+cz4zIRwH9Naa3vHh
 6JGRnk/cLSUDO4VVcotAWBNmVjTDChhdynB3N063Nw==
X-Received: by 2002:a17:907:2d13:b0:c42:e6c8:e496 with SMTP id
 a640c23a62f3a-c42e6c8e7acmr454654666b.36.1792439291461; 
 Mon, 19 Oct 2026 12:48:11 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dd257csm405161666b.21.2026.10.19.12.48.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 12:48:11 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2020706f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:48:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxjLwy8w3HUs2txy1kmzHCh52copp8tPAkiuJjeQBhk4u0+pDX0l+tXXriW9bm4v49YFvalHdr3AOE=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2f86:b0:48d:fd0e:a117 with SMTP id
 ffacd0b85a97d-48e079759c0mr21203426f8f.5.1792439288293; Mon, 19 Oct 2026
 12:48:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019185857.2381360-1-luke@phorex.org>
In-Reply-To: <20261019185857.2381360-1-luke@phorex.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Oct 2026 12:47:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X51pmUxQd=rFQ333DiympCUh6ChsgkFcjz7hX3LyeRJQ@mail.gmail.com>
X-Gm-Features: AclHuK9rQvtNMpUIS09Hn_DNkYREgrHvZlpXBPUSvrKp_n9lGM985rbebpJYrHw
Message-ID: <CAD=FV=X51pmUxQd=rFQ333DiympCUh6ChsgkFcjz7hX3LyeRJQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add BOE NE140WUM-N41 (0x0d9b) panel
To: Luke Macken <luke@phorex.org>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 19, 2026 at 11:59=E2=80=AFAM Luke Macken <luke@phorex.org> wrot=
e:
>
> The Lenovo ThinkPad T14s Gen 7 (Snapdragon X2 Elite) uses this 14"
> 1920x1200 panel. Without an entry panel-edp warns at every boot ("Unknown
> panel BOE 0x0d9b, using conservative timings").
>
> The panel's timing requirements are not published, so use the same delays
> as the other BOE NE140WUM entries (delay_200_500_e80). With them the pane=
l
> trains and lights up reliably on this machine.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 09 e5 9b 0d 00 00 00 00
> 0c 23 01 04 a5 1e 13 78 03 ce 51 9a 5f 58 8d 26
> 16 4f 53 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 33 3f 80 dc 70 b0 3c 40 30 20
> 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 4e 4a 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 45 31 34 30 57 55 4d 2d 4e 34 31 0a 01 ca
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 60 42 60 42 3c 00 00 00 00 8d 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 cc 90
>
> Assisted-by: LLM
> Signed-off-by: Luke Macken <luke@phorex.org>
> ---
> Changes in v2:
> - Include the panel's EDID in the commit message (Doug Anderson)
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NE140WUM-N41 (0x0d9b) panel
      commit: 748ca393b93885e255d3da3897a2a540441fb0fc
