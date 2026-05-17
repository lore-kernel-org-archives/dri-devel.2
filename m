Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B916CD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 23:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3938210E08E;
	Sun, 17 May 2026 23:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="QYUTWIWs";
	dkim-atps=neutral
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAD410E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 23:23:47 +0000 (UTC)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-8354461da74so639666b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 16:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779060227; x=1779665027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Memv/R2VlQKzvDt/cm4zRyKloApfSRgu+HovYgi6/VA=;
 b=AJDI1VMpGRK+aeP/GwJ2O1MKbVlXITqarh3txo1X1MveqRCD/C/sO+gPs5RwNT3oGh
 ZUUIsBpIVhiDFpOuurpT+my85/0cuI7pQeLqkrqE9ALnuRJGTlDfI/CN88K+qwd46IfO
 R7AUBCpoH5GdZhMt7qTKwUiJQgAxTzzgZLKMAqzQ+K6qO95pWzmj4QNFqiVhTVwaBfCh
 1Uqv0oEmw8tQFnPcbuThBJZyLpfSzxiWKUOfVQOLYYVI8wyy5f7AWgITR5w6gLeA6BMa
 4f9LY2XdFMjJpjOjK2PAhbHRU0uON33nuEuG6zdxnQL6m15k7R9gjgKyhDkLcTb6ciWd
 EyMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MUiXcOjfI/0GT6zWVlKcEa0TESVUhDbOTem3t5dCIgScrJBHtCyp6iWRnE7hJUUrg+sjutxl62c0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn07tudCJHqwBdscTRu4nTtYtgBrRbAsF5QTwQWKBz2F736jSr
 3TPno1zGAYD3lET78bx+VPIUcKPTi+pyL8vXddrpqwgIFca9HZ1g5iGehq3KQpe5imDmpsD6wYp
 oL6MbFnK+C6K4xQUEXugWC0Scc0gwYAVZKgbewy3Vqns/Yu9fnxjNndnQX3/j4dlY1/jmgSnbHO
 oNqEDUkeQ5P/vV8uaNGJh/W+PNS+tOzsFy6MICtJPwMOi3zRg+McpOBABgp5P+BsMPwfHxCBhyd
 F6m9CS14BGCKIU002zV
X-Gm-Gg: Acq92OFC5yKCUtSR9qeYLR9GHYpXXCeQdJP2Hgtbb312DYPHZH6et85GMqFRVeI38cV
 ID+eHBn9qbgKdQoZDzR3DiF07QR66eAYm2Fwj70ny+RO3PlGuu8ms89IyRckaEO6kO1QTSVx+Kl
 WLq0ZXhNyNl8WdtXcvubPMn9lgWoXXa0BnodlU3lxFtu6EY6ouW5/abjMuejlYOSZuoXQ4/caBR
 MXCmNchx3O5Lzutf4ZgWSiF/eqo44tRteHxBCcaH3yARcnSU2D2E0ZEiurlG8Oxt8q8YPUwM+LX
 wX3ClUyoxcMGrDkQFTSuyNw7geQJQ+bMhrHsF2weAPzKQ42jny40HldGGGXfHmvdTWFlHNi3YdW
 IQ+ctIDV9XVpF8FK6h4kmYLl/EL9IoMIv6kXVpRsPjllq4N2FursrWf97NUB1NQ3WeCkBAYZo7p
 tF1JnZIRV+PYW8A1HtJ52mEdwHh3wkc6X7wF4XAX/xlpdaewqgEgo8FA==
X-Received: by 2002:a05:6a00:3312:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-83f33dee670mr11991977b3a.49.1779060227022; 
 Sun, 17 May 2026 16:23:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-83f196138e1sm900311b3a.1.2026.05.17.16.23.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 May 2026 16:23:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a3febf3b1cso1063312e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779060223; x=1779665023;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Memv/R2VlQKzvDt/cm4zRyKloApfSRgu+HovYgi6/VA=;
 b=QYUTWIWsBq3ltSiBh5uu3UpY/KvfoOFUBZvpb8YwwdInMKGCdIsiV3sHoCli8DaZct
 kyoplovv3ThLG77HVxsnl1mthGeLUAZwM8j7id88kFf2AvHENAn8PDPUnTA7HikXDcKT
 O54MlkocDRWSVvS9M+sWtdghQERI7w0uwOPy4=
X-Forwarded-Encrypted: i=1;
 AFNElJ+8mjP2o+Q+HvZbEoCpjM2G8Z65FTLVQrFzzQoaGLA6Qdtrivfjz8Ws8yc8vkiQQuO7bFmayIzn9GY=@lists.freedesktop.org
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr3795782e87.0.1779060223476; 
 Sun, 17 May 2026 16:23:43 -0700 (PDT)
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr3795776e87.0.1779060222874; Sun, 17 May 2026
 16:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260517-vmwgfx-uaf-report@berkoc.com>
 <2026051743-genre-cacti-bdf3@gregkh>
 <20260517-vmwgfx-uaf-patch@berkoc.com>
In-Reply-To: <20260517-vmwgfx-uaf-patch@berkoc.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 17 May 2026 19:23:30 -0400
X-Gm-Features: AVHnY4KddQCxh-IYjQfqzIqbe5GPMsqDvunQJwhvRqtpXP9eVu6sO5TlPYYBtd4
Message-ID: <CABQX2QMuLf-gDSfcoHgSrzjY8CyN9GSpt8J7Kv08QeeQMDUxqA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: validate execbuf header.size lower bound
To: Berkant Koc <me@berkoc.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ad764006520bbc13"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--000000000000ad764006520bbc13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 10:07=E2=80=AFAM Berkant Koc <me@berkoc.com> wrote:
>
> Commit 32b415a9dc2c ("drm/vmwgfx: Validate command header size against
> SVGA_CMD_MAX_DATASIZE") added an upper bound on the user-supplied
> SVGA3dCmdHeader.size field but no matching lower bound. When
> header->size is smaller than sizeof(cmd->body), the size_t subtraction
> in expressions like
>
>   maxnum =3D (header->size - sizeof(cmd->body)) / sizeof(*decl);
>
> underflows. The subsequent bound check
>
>   if (cmd->body.numVertexDecls > maxnum) return -EINVAL;
>
> is bypassed because maxnum is ~SIZE_MAX, and the loop walks
> attacker-chosen entries past the command buffer.
>
> In vmw_cmd_draw this leads to a 4-byte OOB-read per iteration via
> vmw_cmd_res_check(&decl[i].array.surfaceId, ...); on a surface-handle
> collision, vmw_resource_relocation_add records the OOB address as
> rel->offset (29-bit bitfield), and vmw_resource_relocations_apply
> later performs a 32-bit kernel write at cb + rel->offset.
>
> The same root cause is present in vmw_cmd_dma (suffix pointer-arith
> underflow leading to OOB-read of suffix->suffixSize) and
> vmw_cmd_shader_define (size_t wraparound passed to
> vmw_compat_shader_add).
>
> Reachable via DRM_VMW_EXECBUF (DRM_RENDER_ALLOW). Reject undersized
> headers at all three sites before the subtraction.
>
> Cc: stable@vger.kernel.org # v6.18+
> Fixes: 32b415a9dc2c ("drm/vmwgfx: Validate command header size against SV=
GA_CMD_MAX_DATASIZE")
> Signed-off-by: Berkant Koc <me@berkoc.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index e1f18020170a..6f9c7d61cc66 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1506,6 +1506,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_pri=
v,
>         bool dirty;
>
>         cmd =3D container_of(header, typeof(*cmd), header);
> +
> +       if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix)))=
 {
> +               VMW_DEBUG_USER("DMA cmd header.size too small.\n");
> +               return -EINVAL;
> +       }
> +
>         suffix =3D (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->bo=
dy +
>                                                header->size - sizeof(*suf=
fix));
>
> @@ -1572,6 +1578,12 @@ static int vmw_cmd_draw(struct vmw_private *dev_pr=
iv,
>                 return ret;
>
>         cmd =3D container_of(header, typeof(*cmd), header);
> +
> +       if (unlikely(header->size < sizeof(cmd->body))) {
> +               VMW_DEBUG_USER("Draw cmd header.size smaller than body.\n=
");
> +               return -EINVAL;
> +       }
> +
>         maxnum =3D (header->size - sizeof(cmd->body)) / sizeof(*decl);
>
>         if (unlikely(cmd->body.numVertexDecls > maxnum)) {
> @@ -1915,6 +1927,11 @@ static int vmw_cmd_shader_define(struct vmw_privat=
e *dev_priv,
>         if (unlikely(!dev_priv->has_mob))
>                 return 0;
>
> +       if (unlikely(cmd->header.size < sizeof(cmd->body))) {
> +               VMW_DEBUG_USER("Shader define cmd header.size smaller tha=
n body.\n");
> +               return -EINVAL;
> +       }
> +
>         size =3D cmd->header.size - sizeof(cmd->body);
>         ret =3D vmw_compat_shader_add(dev_priv, vmw_context_res_man(ctx),
>                                     cmd->body.shid, cmd + 1, cmd->body.ty=
pe,
> --
> 2.47.3
>

I think you might have forgotten to disclose the tool/llm you've used
for this. Using Claude Opus 4.7 I've found the same issues and the
series fixing those bugs is available on dri-devel at
https://patchwork.freedesktop.org/series/166024/ . If you've used a
different llm I'd love to know which one. And if you have a completely
different tool for detecting those issues that'd be great to know as
well.

z

--000000000000ad764006520bbc13
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIN9Z
12U99mOuioxv4gJX6yLou44nAcoGAND5v1gasVrPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUxNzIzMjM0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIcObEsQuhO8KA/t9jDlOo7z/xfJ7lJQs6sNW5Rs
TIkfJUnJ99Cj1gjzkG6a9A/as/s8YiTAqHAwGHomT36S+LruH/UStU4Thpr1wxXn+Q7lXu0tdVKU
w6lIv3WzHl8fupYm0u2mtsL3AhvAEHYMAR2Yb47yKfnPYNpTKfjvWn1aezXMULurYqmpi3fB4dir
hHMdsDnRof7tkqK7jzdELLbZGqspPkaG+8tfC/4Eg7Ww8/Wh+6BKfbmShEv2cvrJlVxOFShvSpR4
lyM6j6KFAFhNB6yOxRMzbbmnnNFtX1aBpkfuSbXIMBjMJDmX8NHHPH12CB2e8iiDO+kU3OZOSAQ=
--000000000000ad764006520bbc13--
