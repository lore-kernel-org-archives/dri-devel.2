Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86921CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7CF11242B;
	Thu, 15 Oct 2026 16:41:34 +0000 (UTC)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C30D11241D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:41:28 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2e977109392so2636605ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792082487; x=1792687287;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7WYpR5BP4WkLP+ijT/G9SXn2D9Kktb1DvKKRg0dUU68=;
 b=BFIJM6uVoqqouBHFK1cUcqXg00keQPsaUtWuzMt4d/3Y2/BLu5OSEiAdradsEOTBV8
 hocaDPZFM+oTxWmsa7y0dyfQz26Wr2WOvko9/veEmhyHBjNYp3kGjRZNh0SRLWN3uHNq
 mCxa9Ds2k982wyGS6X4u1gz4r/+H4JRz/Dz8KXkdFOwPY2y9kQl2OyO/p//a6NQf52js
 LpRaTdgno6P2VjwJ0Zu0AK+LLQ2Tqn9Dy91mVZ/Lag0swJkO7+R/aJPt/8ls6eNPNN1G
 U5LLJwuz/hISiGP0c2LwuB6iboW4LZFdZk6urYwHi/mqTSb/ttCnMsASC9DZXuBsjWbd
 dtyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdmf8P24pRWJRI41NMyCu1QQEFg6fcJSKOiA2JFQzKWHOsDfsxafFwAbt+NehezHgp5JCNP9xF/Hc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkuVkYsdlw/84QmYRonzykbcnvP7ge6ZMVsnebttra5Xg+tuor
 AFhBdxXm9n3ZNIWnGZmqqUueaQ1utBIfTxZ4P77r64pTGM8O8/GkMmOHjVAF1Y6zSeIxQ+3LeZ8
 6yOzcIEUfcdBgzcHHDW56QyNb87L2AnNH2fTQwaeP8eD2UuQjwfa06jcgNE6t+/DkpAsdWH5c6q
 fO3+wnRKZcvxPyH40HOI6jC+RvFjYyT0KxQc1oddsZOeg0drX2GDJuqoSw9weQ5LPGE7QCZTj/1
 mLVaCwhAOSeVnAXF60TsNg=
X-Gm-Gg: AYBFou2cVsImexgOEz449z8N5xxra8+dcOYidQ2ZZW6n1Xt51eNBvVcXaQ3nti2S4GC
 Aq6p3AExh/eE99JTZvfCYo6Q2MRFG+g/xXulmEwTeXkTxEszbyOyDlU06VWF2cvcCN++ADKBh3v
 DXCClVbNIIvbZ6Txg6Lt496pNAxjXN2oX2JLqnwtanCirmkZsdCw1zdlv9D2jioXd5dxU2ye5DI
 afOJRrnbjHq9jFaQMROI29FRM85Hn05/GZzsl14eOHy7GT5RBz7ZTnM2VWZondXG+r0i9wQCp5j
 9OAjpLgB2O2bzYhxkoz89Qlz7g5jwAGU8L4wtBWNKaGGm0tP4uPIM2bD6nDYmGoj8j6ao2dZBa0
 GPk33728XAtoQMzzjNXnc7X4ZNPIFCyFw8kAld0FFea6kFrSQU1+JqJQn3bgL77dweJb2zInC7a
 KG2LtI2Xvbic3pgDpftEDjKUwLhs1nNkC5Tfc=
X-Received: by 2002:a17:90b:44:b0:3ac:85be:cd56 with SMTP id
 98e67ed59e1d1-3ac85bed1a5mr3937392a91.12.1792082487295; 
 Thu, 15 Oct 2026 09:41:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac9476e9a5sm1943144a91.6.2026.10.15.09.41.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:41:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso4291431c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792082485; x=1792687285;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7WYpR5BP4WkLP+ijT/G9SXn2D9Kktb1DvKKRg0dUU68=;
 b=JG+YfN2WDp1fmBoAU0ls+YXP9VL8zAxRuBCMiYaK10/h9bDa+qSMcjLY6e0pI1uVlR
 VJEZdIEEEF4UbU5fOosAoHE+6qLHnvV/fO5PTb5i6v+iV7CIZQW2aGrUktoLyu8GsUgD
 wvRbieU9mq9TofzA1Ktx6saHj2V3rlW4nEtjs=
X-Forwarded-Encrypted: i=1;
 AKwUvBxjAOhVvZuQ+aOwrJRL6j+FOJIYIq3oU0zMBc0PyruqbABe7yF772NCmNyzNvciHn0Va/SMnLjzYP0=@lists.freedesktop.org
X-Received: by 2002:a05:7022:1608:b0:150:1cea:31a8 with SMTP id
 a92af1059eb24-16a60bf2778mr22288389c88.19.1792082485073; 
 Thu, 15 Oct 2026 09:41:25 -0700 (PDT)
X-Received: by 2002:a05:7022:1608:b0:150:1cea:31a8 with SMTP id
 a92af1059eb24-16a60bf2778mr22288350c88.19.1792082484264; Thu, 15 Oct 2026
 09:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
 <atDXDlI-EhrA791a@intel.com> <d4d5302f-9768-4122-bbab-4384ef7aa9fe@intel.com>
 <atD66da36wMZ0gie@intel.com>
In-Reply-To: <atD66da36wMZ0gie@intel.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 15 Oct 2026 09:41:04 -0700
X-Gm-Features: AclHuK8Hn20-he1ntr5sEuS1MoAtoRltrcvzX1TBPTTlkmmSdpX3cj9PWf6QZmQ
Message-ID: <CABQX2QP08+cOO7EZSWfLJpeAdad9EnzsAUneSvts5Z3ANbvtog@mail.gmail.com>
Subject: Re: Nasty console and xe driver interactions
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>, 
 intel-xe@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f752b0065de3b7b2"
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

--000000000000f752b0065de3b7b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:10=E2=80=AFAM Rodrigo Vivi <rodrigo.vivi@intel.co=
m> wrote:
>
> On Thu, Oct 15, 2026 at 08:30:42AM -0700, Dave Hansen wrote:
> > On 10/15/26 06:37, Rodrigo Vivi wrote:
> > > So, perhaps what could be done in this specific case while we don't h=
ave
> > > the proper one is something like trying to pre-fetch the mandatory fw=
.
> > > Before we steal the fb. Something like:
> > >
> > > (Untested warning)
> > >
> > > https://github.com/rodrigovivi/linux/commit/5589d2883a604d52e89f44620=
e16d16c7fd278e8
> >
> > I threw caution to the wind and tried this.
>
> Thanks for being brave! :)
>
> > Id didn't seem to help. I
> > don't seem the messages about unregistering the old console, but I stil=
l
> > never get any output. The only "xe" gunk in dmesg is:
> >
> > > [    0.739464] xe 0000:00:02.0: GuC firmware xe/ptl_guc_70.bin not fo=
und, can be downloaded from https://git.kernel.org/pub/scm/linux/kernel/git=
/firmware/linux-firmware.git
> > > [    0.739501] xe 0000:00:02.0: probe with driver xe failed with erro=
r -2
> >
> > BTW, "xe.force_probe=3D!*" on the command-line also gets the output bac=
k
> > to normal.
>
> the force probe proves that we can still probe safely, but apparently
> on my first attempt I missed the fact that pcim_enable_device will
> touch the device and register a pci_disable_device that might
> clear stuff and mess with the VGA fb...
>
> Perhaps if we move just one step over:
>
> https://github.com/rodrigovivi/linux/commit/616cd8c1b4d4414cd1f7ad56fa5d8=
abd36d7968d

The general issue with my series from the above was always that it
required two parts:
1) a generic framework to reload platform fb on module failure (which
i think that series does ok job at)
2) auditing and trying various drivers to make sure they leave the
system in a predictable state in which the reload from #1 can succeed.

Every driver (other than the vmw ones that I maintain) would still
need to go through the second step. The general consesus at the time
was that #2 was impossible for most drivers/gpus and having a generic
infra just to make vmwgfx/vmwvg init failures properly reload fb is
not something that'd be wanted. We don't have spare systems with intel
gpu's for me to play with it so I can't help with #2.

z

--000000000000f752b0065de3b7b2
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHXi
nxyhS6Pi9UzgztVEjeeibJ2qIHrZMdCGJ5+BO5uZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAxNTE2NDEyNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI7eQTb2KmHpiZwT7tjQKPEWwjCq48HKL1paQxin
s+vOKQeTzZiLJRizhzPSEwQQj8Bf0Skh2n3qJUSIs4TINedp7akBFHX0kdSSwudF3mlurDgNs8nf
c0Oequ5LuuKiuJDMGg5BG1c4jUcg2HZ1qYWCt659ISTjYILE1pezqgLOukmgbzFtx2U7KjUZyqYc
/nPJyCh0TyvWGjvYIElysVm/urRd+gDrzZLE4hqbMaraQ+l3/FbYcHRWzGXDOZCvAsnqt+Qs5XdW
+yQd3sBHzzxjXKREcKk/fbgUNtxDXwMcQU8AjpzsWE75TwY9POeWJKMI4F/vO/PPUJutl4dSQwk=
--000000000000f752b0065de3b7b2--
