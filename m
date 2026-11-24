Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A62606A695
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6I2ZVr7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2666D10E862;
	Tue, 24 Nov 2026 11:18:39 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C951F10E862
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:18:33 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5be47aa555cso5440973e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795519112; cv=none;
 d=google.com; s=arc-20260327;
 b=M8Omirqxcbk/1/j4SVHDWHuyl2+3lBpT4rQEOT3Jh/AiQ43y/wY4x6AMDLAKZhXvPm
 IpTJs44BhQiT4TO/miH91M2dCytUXMvEwbNRMrtkzYZt85Iaqt4tAZvdmeDtfATx7BES
 gKGMDU7fh6ZInXzgriMN+uNXhBNjy+sex7fmDqpOzxuURjinxFD1w8E7eXoQvvWip2ww
 t4qcW0z6vOCN7YbCTQBx4A+aewCQvkI2Ww6/uQ4yvQFW1L5MjFDh+wPkxxX/2IkuJ+3N
 yXMkXg446AcZKOeeH9i5/Y+8fnz/lcGuzAe/qIFTAHafNR9dUS9CJYEuz8CRFwTbVJfE
 Ueeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
 fh=AAO34vPZ8YfqRgnEBTj+Zxj7p0GRKIsvejjWSTwEKws=;
 b=cau3zTSE2kkNmcIYTwkf30wB69zeRlkDDRVAiVDhiJ9gYgr8rRD2PFWLm5s3V78CLM
 tx7lw4RHE7eU5zHnARO74GTV/pU3fm1u0UI492Am4gJFRLAHWuFbE32DiSGkRxxQFq6q
 CkY8OncoxYC0a01tF6U7UeIQzvYu4AHFbL6eYsqw8/keNJYwjszjJJJh+OhyUoag4zip
 MdiOm/v2juhtvQ+J+O8Lc9zrgbsPlZSDXozeOHceIgFZb3i4sgJslIoyHv3TWmzFtoZq
 T7opiTQtGZ0KWvAFLtNkn9Tu4aQGlMxKlmCsXXCG1BfBVtzEpmOxVACTuSyEsDCRMKZo
 H9Jg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795519112; x=1796123912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
 b=a6I2ZVr7UfEveR03M0OfPdrvC61fOmEDwSDMOAVIu4T+cYBc9PYajuzvuRT0CbRU2+
 sr80dZ4u4Dpiih6B99WAmZUHiWnsXBBWh1SK8o4BdFhjTE9xwoZVx/jzBGT8/CloINvO
 zmHj7gILtN9JN697YQpWcWQmC/d4PGJxukHPmJyt18s9uljJuJxGrSbn/Fts/4zxWCiZ
 X+0aPsNllPEc/Yq1F3K2yny/6EeULFtlrLPMBs4/mp9TV+O/a49aYxpFhkMQ8d43fL5C
 sjDWc4bnIPgwapGddZxy0dJMtI5nli7NW+CuNw9EQ6VfAwCoycwbNxhNjthQR5igyDtD
 xB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795519112; x=1796123912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
 b=tlSxpjVdpNYYhj8k8faq8CgfIZr/tT7K8Vdx3NlevEoZcsunuoEEvSP6gM0nhJDRRe
 Nio8WZf9HP8TllaI4DgiVM3Zblg9HvAfQ+TgLw7Y9fHhbefUMLkNsx8yEBSs8li3K+I8
 ANDv33qtNtwVryN465U4XgMKOFXErRZcUJR/55u37myY8wP2jBzodo/a+6y9xH1z4YrF
 97gECiOWUOKgnh2JJqGhw/eo1Wxb2HC0UWZz3kh+ThFtguLdkMM2iMYcdWQwYmkF6alD
 6TskIS4XasHUZJjbM3PUHdpggee7wAA8MV9ambLG26TKYC8xuRyswMz7LMzMTx3wNgp0
 nHHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH8OGRUB+mSzZPnipg549bX5txspPVi2aEjSm5J/WarkwmteoouXps9TxQhAfpmteD8t+NCtPe/k4I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+CJl2z4vEtinaeHwHGMhMkpAvxEYJ3odbC2yy1GRC7Kmc324IV
 E6XoAoWOmBn+R9uM4w1a6HvoxDMMFhkX16GK3EkZVLCl8j8NRrty4PRS30AiMRVyqxW3zApuCOf
 EZSGFujo1b9TBglRAPRe2a474PC4ogMk=
X-Gm-Gg: AZFdTZcP5FcMOe+fI8bx4+Sh70e2u1UO9wpCgqVRGjDdpaKl4/t8CITiM1s4nMqayL7
 CgfinhZ9w7msqAN0JCmdCAvfAmEDG05vx/B7sn219RtfkxSrUDEnHK+BQIsaYPEZdND900MCDEY
 0dQVvZDl3AEZdBxPbI03quCEUsFuyLIPpFeWsna+AgIgK+xAiwJK116pUDdbJAcJkcz83VyoMad
 3x6Ay2OuhbinuRyzIQznmBuavEeU8mUMJtmjh2RvUZlOGWI0hV89qPnKV7J7o2VdWvlqYnoGlHm
 OrYJq8Rr+luuE2oz2gSkPZVZBfD/fCEIIDPqFNVbRt6s8isCKNXxIbRWVL8OGRgQrWr5hOP7tTj
 PRW/D7AAQJ46W4AVPEZ2IoBWY+hXMVb96IKCJ1wIfMhQ1iT3s4iGBJV+IQ1cwGiL9gHZrsd6dpm
 15N2do6UEWHkjkHsCixAmdT9UWtgA=
X-Received: by 2002:a05:6512:108c:b0:5c1:5be5:a543 with SMTP id
 2adb3069b0e04-5c1bc660a53mr4292498e87.9.1795519111544; Tue, 24 Nov 2026
 03:18:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123223357.535424-1-festevam@gmail.com>
 <179551300942.327856.7174455040291936744.b4-review@b4>
In-Reply-To: <179551300942.327856.7174455040291936744.b4-review@b4>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Nov 2026 08:18:19 -0300
X-Gm-Features: Aa3M54rPCqpnfWWfBJ5P36EvmMGDYSDRBq9WyY_WgO-ypfC7S97pWkWQHrUAf_M
Message-ID: <CAOMZO5ALfN-zGZuVn7tm9gpg+1yO1tQGKt+O2NXem14hbr+_6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: laurentiu.palcu@oss.nxp.com, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, marek.vasut@mailbox.org, mripard@kernel.org, 
 stable@vger.kernel.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

On Tue, Nov 24, 2026 at 6:36=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> I'm OK with the change (except a small nit, see below), but I have a
> general question: is there any valid use case for removing the lcdif, oth=
er
> than testing?

Yes, the motivation for removing the lcdif was to help decrease power
consumption on an i.MX8MP board.

> No need to use the @ret temporary variable, just replace it with:
>
>                 if (IS_ERR(encoder))
>                         return dev_err_probe(dev, PTR_ERR(encoder),
>                                              "Failed to initialize encode=
r for endpoint%u\n",
>                                              of_ep.id);
>
> With that done you can send v3 and add:
> +Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> +Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for the suggestion. I'll send v3.
