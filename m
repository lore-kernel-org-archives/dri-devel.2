Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D4606A333
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMluWrAb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E828E10EC63;
	Wed,  4 Nov 2026 08:58:04 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE8B10E807
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:19:31 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5be4fea434bso631497e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715570; cv=none;
 d=google.com; s=arc-20260327;
 b=fYccx1UdDHaTUtOSHqAc4Xs8g49jitZRgmuogb+9OHBjqWGdgHKv2iOSSqQZ4XvLvd
 6CKHaWq+d2BFV3mO6ILOJH1TT1hruwjePkpnzRqrTVDM0UvjN4X5y+dtgRpAtfVuWym8
 NfJ2TyrKo+nKEk4l8oC/tpSOelbYLX0mi/sgP2m0kKcvUvD37YcvKCQhOrjlm1goHMnr
 aNyPe/vXq6FlVxttLI4+WJipHiMqD4mqUhjWUEGsETbLLJCPx5K2rkpy6FP+Hz5wIDUY
 Cfq7JPeS31M7qoOEcgG/ZuNNxzarPa9ByOGqSloygqhL3M9AS/daslhihi7S7wKG8XWg
 f9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HpFqXDcZjRJLrcm2pPsLXGktcBKbRCtBWwGzeKIx7/g=;
 fh=neRvZ/crjSXvCWLcpLVc3Uekoijw54aRLOuD/arNAcI=;
 b=NdqO5EDZo/ZTiWEJjjfjeOnT5HQl8qJRCC+WpalmUK/tu3RyO9GbW0bByBNNzD49nJ
 qjPx+iVsyXdNethCBj3PSTM/Se4dPJT4vIV9F9nHf56JQ0hX95tBrmRV3/l0YNhNrByr
 b6Aa222EfEQRPYUOBRmOUuziGOMZNERDvz9PJToZf2S9jtO/MrDKgvuKIEJVUtNZgAOC
 3USOVhr5hTyqZ49BgdbYkvYnmFO7v+CYCqenkov0X2l1jM7CEYNhHaIgwZLcFf4IrgIm
 v/+JLX/meDO6ogkbTmLVII/D7A6W6TuKcRTMyTBCSRqRnxJiG+P0f4b6UwZ/9evdmiEY
 e/Fw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793715570; x=1794320370; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HpFqXDcZjRJLrcm2pPsLXGktcBKbRCtBWwGzeKIx7/g=;
 b=DMluWrAbvU9EOmzUWA0UA2dbF8ssCDKrY1vVOxh03fSlz/vaL2/3IJZ/OknmrHcU/B
 karQfp3m72S/qJqH1hKOEsbDpiTM5PNXNuC5gtG74ErLRXcObzAct63pCURdx1CgAtql
 DyaPoUZaTCcI9luqy2Ubf/45dXWIOMjCVdDzKbhYQ2mSJAFUV0g4AmCHht5/GauPbZLr
 6gRnAQiavYpMTLaSm02vu/+Ck0mL4x5AYTVbxU43LXMGJ3gn726N6mglbJ7DSX9r+gaF
 On4XFNvjpCOzdLJ0wHjYKVmj3FgqRw8hmxFdPxTFinr3zUl79+0YUogIq3DIKNb/rf/s
 VIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715570; x=1794320370;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HpFqXDcZjRJLrcm2pPsLXGktcBKbRCtBWwGzeKIx7/g=;
 b=DlD8TI6AeDvi4atVXGpfl4bDl/wUQNOnGqyneDQqm589k/ximWBxPDH6MEbC39RiWG
 9hGT1Ox3TydDr7MebnTBgc45ys+UO8MBFfW2MTFoaUu+er0cwaOmv6Vbe7Ssn5tZXJeD
 /KA4Pp8dlADbvQijsyBCYQorCDVwpF0NKZCclldNkOmepNfqIGyOC4m8BwbcvX+SQ/TZ
 T2gi0o2oqLD/p271NQF/ujW9ws3d1GWwaMeQBAtu91S/bdf5FTTmi5rukyLMbNijSC0A
 LpsXpjWA8K7rPgkKdSMp5976zxWfZhNbnmWONOsxipsteptGEUHxsfPaQWb3QPx8XEw4
 7Dmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMVZn9mqVhDdykswILbMnMODKDId4Fhe/UL3DK+0y7ox7130g4DqxMyhpK4DS69j3mbsa21RI1TAg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+N5tOZZXaE1RO5oRdqlsP0tmK+OXyPirWMan+2DdBvWrcMJ1dX
 +DgJxQrKjSYTo061Ktv7InUW9Z83SOeM+Yd3lgWSZ87Iu9q85FPMUveXqtlb3z9ayWuIdOd3USO
 JaU2/OO97XVpqqf4mzW+zTH/2KrTpOyw=
X-Gm-Gg: AYBFou0AV/bxJwjaW3B130UgYD6FLXx1jOxljngqpaCv4LeOGCMycY73xgYY9Ap8laX
 SMyb/iPRC25uXS3of0UDyT0rEksiUdQXgGHjEmyMMdcxUfdkW+IL80WIOaOBQtb7dIU9Di24L6P
 yTElAswP/7Ns4qpOluhk8S5dWIf3mD8THUR/bZCxFJnbJuo4t+pm5LzhXxf6ruYLSh8014m02X9
 LEIZBosEsgrXqqXDrrTzwALoHPV2Za7eb+03L2g0B0nd1u6F7is8iln/jI8v7dlf90BuLO827sR
 MtxI7eoB++dbj52kpxSmgw1PzSgxvb8UpecKdrAkAFRh487d0crKHevBRuRdWAyLkdquxvl5bN5
 ZyNeHKxzrL71mKcvI9PK5diO+pYx06raEQUjFAHxNMc0zNWLA6hSHyD8AO/2yN1ycX0h8JmfgmG
 5kvoH97TqpBDjEkVX3UaNfgZMx/WVgT87GbO5MArYAwAEZq7glXrAL7dk0moVfDdrDsdNm0fZv8
 YWSU8TOjeRB8oT4/65mhbfU20SJhlP0QEa88Fz6AeP2
X-Received: by 2002:a05:6512:361a:b0:5bf:d2aa:abeb with SMTP id
 2adb3069b0e04-5bfd2aaacb1mr3055248e87.20.1793715569649; Tue, 03 Nov 2026
 06:19:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-1-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-1-88f2f24a5f0b@qti.qualcomm.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Tue, 3 Nov 2026 11:19:16 -0300
X-Gm-Features: AclHuK8iuWx_PT6P7N_TCJlCYwfej936uif1OBa0Pk_vlcx5ZLqlhS-8ZHFWdXc
Message-ID: <CAMAsx6cNcqHLHHgS5ZxvnK2fjrV74WmsZ+8peLvu0gwPjFr+6w@mail.gmail.com>
Subject: Re: [PATCH v4 01/25] accel/qda: Add QDA driver documentation
To: ekansh.gupta@oss.qualcomm.com
Cc: srini@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 07:37 PM, Ekansh Gupta
<ekansh.gupta@oss.qualcomm.com> wrote:
>
Hi Ekansh,

The document reads well. I only have a few wording and consistency nits:

> +The driver binds to the device-tree nodes described by

The kernel documentation spells it "devicetree" (no hyphen). The same
applies to the other "device-tree" occurrences in the file.

> +4. **Context banks** (``qda_cb``): creates a platform device for each
> ...
> + They are created before the accel device is registered

"They" is ambiguous here (the platform devices or the context banks).
Consider naming the subject.

Thanks,
Daniel
