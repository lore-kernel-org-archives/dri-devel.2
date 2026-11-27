Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7328606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVm9h8YQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6BC10E523;
	Sat, 28 Nov 2026 09:41:02 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202EC10E2BC
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:09:05 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso1501183066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:09:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795777743; cv=none;
 d=google.com; s=arc-20260327;
 b=iiDgortiJ/7i+0Ni4zQHQVLnjJEMEb0UtKf1MGQkJKL+YXo3ZKQI6JxjxEbTzD0jc/
 Pn7yGTaygLRE3IxM8po2vFlQlqwuwu3xSrT5kjrEkcey2x6gt/aACaO/fNd73jRHW1Fq
 YJO8mqns7SwVZonYY20jqzKVLcWgze+XlZyfmOX7w7XaHFDfN49S2ahn53o4eugBKcg+
 06ChsD+UOmaQFlCYEP79F0d5Dd/YegqAiXH7wn8G+JFr9LJOILdTrJ+GMK0i9Gym8XXg
 rrOHL1V63tZoGEyIjZ6hrDgvbEyT9j4QTVQ+V15nAMAeVB3KpdtkfDXRwB5ncsO7hZRh
 ahYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nbVQk9AKy8lstmppQr9dyYw5GQ/bdNQp4GNRHaf5JNk=;
 fh=ILh8etUWREZMbEk+wxzpJBN/TnSH0cVWEH0sSlct6xY=;
 b=b7pSFW9vwsAWyDFiE+7mD5CZBawT42lwvC7NpK7Luj32OaHjmVbgUsNqZ5chXURZs1
 gbnpPGShmyK0e/Mz2+h8AxckRWJzjxKrMaQyTdQ50mTn4/5ADrvr3KDUaeg5D4g6t8Mr
 00OvNpU7Wl5kZmizQ4itoZ/YuRJus2TrcSm06Yh08q+rOy7EiHpRKziAoiZyic9iyFFO
 ozGTQ2ce7XH9xL2OEQep8/HenEHxk7ophAiYxFxiuq3gBQqMMVntqEPrApdqle7pBrbb
 z2ORnndZqXbg+bIJ1SO9kaYdETN5FYaKMXLbpsZ7W4DNwyCh4NoqFcyxz4aR13DllGk4
 ZEPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795777743; x=1796382543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nbVQk9AKy8lstmppQr9dyYw5GQ/bdNQp4GNRHaf5JNk=;
 b=YVm9h8YQLGJn5oILs5aud/qJdcM+1moaoW8vtcWnwQfB8K14cM4RozIt09RdGgr3B8
 2PjPILKsCoFEGSlc+ItOfZ7C2Ttxpeq7zuWFEv9zF9KKtiBSatYgH/wPUaegm+5mTIGG
 OSW1peYBFrJSF+hhyNmS6NB1NNTji5QxT9a/YaycICAztzDmJ1GBWgVCPDsIiNWLKOxg
 QzZHixSB/FhtgRKrD0ttdz4xxUAxcoQ3wI+Egg9DQ+93GJyXH8Lco7+Gcy2ApREr1CpR
 NGo5HkQ3n+0MtpL74ZWK9sC64mjan8DHKHHWKksJR3hwdViQvJRxmvhRonkKbWq6LHGy
 jtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795777743; x=1796382543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbVQk9AKy8lstmppQr9dyYw5GQ/bdNQp4GNRHaf5JNk=;
 b=HS/AdVfAjzV2ohnQURpqs+0+RXJzpn831nNkCXhmxnz7+yYHJbArVjr8oRbRVabD1H
 qslNsNzZFXN9Y2Dl/jfwKC6aJuereveptoS5giLrwb1senh0NPdSRXno903REc6IWQOT
 klw+IGY82/iPN+OB8qC43T4mNIB0rq4rDTjDGS7R/xgsuMmqrw3HKRrkmmnQLmF5UAUt
 8mt7iWYHoOBNjNp0dWQRo8p5wBPu6SkbmVzWrAbbxGV43c1pZEVQ0WXE2OJRQnnH6R6L
 qrN2QKDyAEMNAjXgEgiVvOvd9IpzkT56gAjfq2AM3pxAFzl+JXho556GuCtNF5Rrr+ab
 YD7w==
X-Forwarded-Encrypted: i=1;
 AL+hErFIy+et66YlbGk0y8iejb9ntHlwwiBgQUG5HsV5LgUHHZTc0nagA1zv5DUbbWGbu20dKw0vxWcFGqk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/chwC6fCeR1+sfQUsZy5M4Dq3lUnmMut/e85eOQdDl7z/6c7eW
 C12PHKpxWeii/ttQ/Sgs4oVzq6oWORAnwVHClZx8sdwgwrjw0+z9TgvwzUxwze2YCA9M9EvO2qu
 WLPirQkJ+pHs0DTxvVJpeaw4lWAsK+8c=
X-Gm-Gg: AZFdTZdsG11mSTvdYMnFPkONL0cBlDflCgroNcMJwcy2f1kiTiAhL5GstEidXqbnJ0m
 U4HGpJmBkl7F68QlmIzdxKuNGzssTU1djcJEaGO+aloiEkQiu345gJ3wE1VmCHi+UoIG4TVhw36
 Q2Rh4La346pIKS8VAdUKNaAQ+jVNZRtY3h9ACVi/htAttpIKf6U988d4Csb6uPLnKvANV4ivocB
 sTj3DcS0Rd/dzrkh/9TXGFFNjfnBTNp0EdWvLPCU4O8JXDcbrmOqtUSjrChfz+Q7jrJaDVV6QKg
 k836lzUqclF4f28npSsmtEQw3PLmcPFD3dDnycJqYbOkooEI62k2YDp4R3dPO99LI+Nr4aRIRKd
 rKkHpAaw936hDJG1TslGDum+YShkTAydlqFtM8R6xTdOgqD3p16jjZPvcBQW2Azq7GjKEqaEaNA
 JPcDoTEUXsOq0Z4hE=
X-Received: by 2002:a17:907:968c:b0:c51:205e:6e8e with SMTP id
 a640c23a62f3a-c51319b6e77mr2114253866b.24.1795777743206; Fri, 27 Nov 2026
 03:09:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
 <7c3674188150b6c7e4da1a7a970c53b545e732e2.camel@imgtec.com>
In-Reply-To: <7c3674188150b6c7e4da1a7a970c53b545e732e2.camel@imgtec.com>
From: Wong Steve <shyckless@gmail.com>
Date: Fri, 27 Nov 2026 19:08:51 +0800
X-Gm-Features: Aa3M54rejmq1p0vEJLPwwFfXDeSKaDA7Ox9t3eoq8elk06o113XEjI9tEXBJlQ4
Message-ID: <CA+X8Sdhk57Mb+iazzBZinyzXeb3JupLWnim=3FCK097-PuBKpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/imagination: Fix leaks in HWRT data set
 handling
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: alessio.belle@imgtec.com, mripard@kernel.org, 
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 airlied@gmail.com, simona@ffwll.ch, tzimmermann@suse.de, 
 linux-kernel@vger.kernel.org, imagination@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luigi,

On Thu, 2026-11-26, Luigi Santivetti wrote:
> this series looks okay to me - thank you! I believe patch 2/2 might need =
to be
> rebased, the line you are changing got recently refactored.

Thanks for the review.

I checked this again. Both patches apply cleanly on the current
drm-misc-next, which already has your "drm/imagination: switch to
inline init of rogue_fwif_rta_ctl", and also on drm-misc-fixes (1/2
with a 4-line offset). 1/2 was already based on top of your change.

2/2 only changes the type of hwrt->max_rts in pvr_hwrt.h, from u16 to
u32. It doesn't touch the rta_ctl initialisation that your patch
reworked, so I don't think a rebase is needed. If you see a conflict
on a particular branch, tell me which one and I'll resend on top of
it with your Reviewed-by.

Thanks,
Suyuan

Luigi Santivetti <luigi.santivetti@imgtec.com> =E4=BA=8E2026=E5=B9=B411=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Suyuan,
>
> this series looks okay to me - thank you! I believe patch 2/2 might need =
to be
> rebased, the line you are changing got recently refactored.
>
> Refer to:
>
> https://patch.msgid.link/20261104-minor-improvements-v1-1-cc976128538e@im=
gtec.com
>
>
> This series is:
>
> Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
>
> On Sat, 2026-11-21 at 15:47 +0000, Suyuan Wang via B4 Relay wrote:
> > Patch 1 is v1 with the Fixes tag corrected: the error path that skips
> > hwrt_fini_common_fw_structure() came with f1f55ed3ffe4, not with the
> > commit that added the ioctl (thanks to the Sashiko review).
> >
> > Patch 2 fixes the other leak that review pointed out: the 32-bit layer
> > count is truncated into the 16-bit max_rts, so the SRTC and RAA objects
> > allocated for layers > 1 can be skipped on destroy.
> >
> > Found with a static analysis tool and checked by hand. Compile tested o=
n
> > arm64 (W=3D1, all files that include pvr_hwrt.h); I don't have the
> > hardware.
> >
> > Changes in v2:
> > - 1/2: Fixes tag now points to f1f55ed3ffe4. No code change.
> > - 2/2: new.
> >
> > v1: https://lore.kernel.org/all/20261121-pvr-hwrt-common-v1-1-784ce45b7=
82a@gmail.com/
> > ---
> > Suyuan Wang (2):
> >       drm/imagination: Destroy the common FW object when HWRT data setu=
p fails
> >       drm/imagination: Don't truncate the layer count in max_rts
> >
> >  drivers/gpu/drm/imagination/pvr_hwrt.c | 2 ++
> >  drivers/gpu/drm/imagination/pvr_hwrt.h | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> >
>
