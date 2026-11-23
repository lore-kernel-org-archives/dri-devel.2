Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6515606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UkF96ct1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFC110EEE5;
	Mon, 23 Nov 2026 16:10:08 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C122F10EEE5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:10:00 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795450199; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:EzEbCCOT4i0r2sDW+rxpY61LjnCe
 1t+wcobk7qKwRbMOkY//lgSPL63AgEnsqul+Iq8wPX833RO054fBGFDlx1o/MJLYYkCmg6Ihhoy
 HH6ERNxU11+gt9X70AiWAAMBK+OnoQhkYc/WxE25fJ6P68rNgTJvTToINc3tl65Tjx0hlmJceIt
 jSYpR54DISbrIbMSddhbuVbHSi97Izfrr3iXaHgw5fXLrn7uWB+PIULqN65Ksl7uMOX9YPZnZhU
 +CUpLmdUc5nDi3TnoVUhxwBxAw2kWQNQLQUtw2f6MuWWm3WCB/EnkBMkmbawNt5SyKPFBXMLhrm
 4FPTzC3ruaLpRg==;
Message-Instance: m=1; h=sha256: nQhklY6vqjYkSO+BCcuTrPVghQDcE7zS0NPmw+AvEBY=:
 2TgNx5rppG2R0ilKw3OeoEydrQVA28fRQUT05vrqb2A=, sha512:
 ErBTnzd1hAP1tyNt0RhnxPp/W16g92gErBwma5G5rYBPSLOhTeqqxqWQ/VLoBxB0dhTvje3/JGUKtNk91kQZYw==:
 aOImTt/uDp0fHWRTxc1Pb38jjAo1dn2M36nGMdNHoDPYDxtzSQaC8zdf2lAv/qa7MGelsqO+CKLf9ooLzRNQRQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795450198; x=1796054998; i=deller@gmx.de;
 bh=GrOQ1ysKWwV+qmJqmtEjWHgndd4OPKW7HNWCKDKQQJQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UkF96ct173/XSm2nhKuQDcSsA19MSsfU2JhYVfEqq9VJYc22/HWr6c3YAICXZhLv
 rlo7j9IOqTY7zNJ/YyA+6bGhzgJK13svTxoJhpaHOnvpxSoG3n7JxCN/BtKIau64y
 rngsHMvqOktghgWSdCwD7dcqr+RV/iGjj+BPHeX6B6pVHcnYjpHMH6Vo0dPKxLmMk
 2V4WazsjMtQ0SHGHNnFJHH7S2MYGKiETbzmTEKruqBoSiBbvoqyLN3XMx/1Yiqf/w
 nUeogzMaa+FYK1x+Cgo3AMKQrdHpt+G8hvBje2jgqedZSYOpd/9T4ag7fwQdmF4pl
 se1YygUa7zG3o6GIxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1xkMau1J42-00AHwr; Mon, 23
 Nov 2026 17:09:58 +0100
Message-ID: <a2ffabc2-4096-4767-8124-c77e5dd79564@gmx.de>
Date: Mon, 23 Nov 2026 17:09:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jianqiang Zou <jq.zou@outlook.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261120175413.176249-1-deller@gmx.de>
 <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijL9+DgED6yaDg7X9xRP8KserFHH1ByCvA8xeheQk7U4G9yCu7x
 4tErcbC64dR4shriHUmnqYMj5/riZgRLDdFEGqrodAzyHsanXIfHT28yX01cb0wPTuBAEmU
 B0s4q49m9L9rXfQr5+4flPujofCpuM4EP9bwirzv5BNCN792vJA8+ydfq+aR1haESYTOBu4
 mRYDpWGqEHC1dWFrk7KPA==
UI-OutboundReport: notjunk:1;M01:P0:CbxfacF+Ql0=;eBlP8l+6+hswdGplljieK13bzQ1
 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
 TwIRGLLeZmBwgJrzo4jj3aXc6RQJ9m5cjl4Wd9I=
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 08:52, Geert Uytterhoeven wrote:
> Hi Helge, Jianqiang,
>=20
> On Fri, 20 Nov 2026 at 18:54, Helge Deller <deller@gmx.de> wrote:
>> From: Jianqiang Zou <jq.zou@outlook.com>
>>
>> radeonfb_set_par() derives the dot clock from the user supplied
>> struct fb_var_screeninfo:
>>
>>          dotClock =3D 1000000000 / pixClock;
>>
>> where pixClock is copied from mode->pixclock.  A zero pixclock
>> bypasses the existing validation and makes the kernel divide by zero
>> in radeonfb_set_par().
>>
>> The driver does have a check for this: fb_validate_mode() returns
>> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
>> the output has no scaler and an EDID-derived mode database is
>> available:
>>
>>          if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)
>>                  if (fb_validate_mode(...))
>>                          return -EINVAL;
>>
>> mon1_modedb is only filled in when an EDID is read, so when no
>> EDID-derived mode database is available the validation is skipped and
>> the invalid mode reaches radeonfb_set_par().
>>
>> Reject a zero pixclock in radeonfb_check_var() before matching the
>> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
>> ->fb_set_par(), so the invalid value is rejected before the mode is
>> applied.  This is the same check other fbdev drivers use (i740fb,
>> arkfb, s3fb).
>>
>> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
>> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
>> single FBIOPUT_VSCREENINFO with pixclock =3D 0 is enough to trigger the
>> divide error.
>>
>> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> Thanks for your patch, which is now commit b3f1631d362539cf ("fbdev:
> radeonfb: reject a zero pixclock in radeonfb_check_var()") in v7.4-rc4.
>=20
>=20
>> --- a/drivers/video/fbdev/aty/radeon_base.c
>> +++ b/drivers/video/fbdev/aty/radeon_base.c
>> @@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screen=
info *var, struct fb_info *in
>>           int nom, den;
>>          unsigned int pitch;
>>
>> +       if (!var->pixclock)
>> +               return -EINVAL;
>> +
>=20
> This violates fbdev API rounding rules:
>    1. If a value doesn't fit, it must be rounded up by the driver,
>    2. If a value is too large, -EINVAL must be returned.
>=20
>>          if (radeon_match_mode(rinfo, &v, var))
>>                  return -EINVAL;
Oops... you are right!
Jianqiang Zou, will you send another patch fixing this?

Helge
