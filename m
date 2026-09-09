Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B88C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6022C10EFC5;
	Wed,  9 Sep 2026 08:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="X6pWCz0b";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CD610EF7A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:35:21 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so4428034a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 00:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939321; cv=none;
 d=google.com; s=arc-20260327;
 b=i8E9aGpdgJK73AVwSmAjoUSMXKPtvqSMRSTKExJQPnOjWNioSzUSvlmA2Gllt4+5q/
 JCoRJd1lal8RfNKBkOY1e2I5IxmkJ7fGDUWzc787Efl/QetoRD+oLupTNDBlNgAcn3Q5
 E5LIYuWgPkj1rx5NKk6v1wMUeFQeqthyh6ejtr3WiQpYCSudsKxAw4gGrEKSPdJYy52B
 vS/JsEFJYngzuCCzxjcGElgVLOjpIJFCxdhxiwFZhJ3XLX9CUUxFqk2clKWe8A9hOQ/P
 XxptAIxc2DvdFSjMG5GuMX/ute8NW7lWZEr4TWjr6yQWqw8sGpE05WeUXZvb9u/0IVQx
 A9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xcudaz2PnKA/xLelmlRmiE9DkpwYzgpiv7HoBDaaLig=;
 fh=4nnTC8oPKl/O6fOcIbzPt9MVHW2Qpy7pxb5gA8CKM6A=;
 b=NM1UIuu8fMe2Wp1XozhYhtACksZQrDp6lF254K8mUqScoLKdVoIS4lJoYW6nGbdm9Y
 FtW2cRCuxwVmULfhWU80jIPjc09jFwSEhoygPU4WfOtVzPx9RveNQrPF+fki4MGFBOkf
 uE4mQDGzfK0e/iW6xToV+aYBI3js1khYQ0Y2mahsHIGfHYJnT8oLgIJIoPa4IpbF8vjY
 EOlQzFYV9ajxLnENn55nj4oP8tUH4TRwNkNtnUWs3At01ZU6QINL6P+mybfpHLT1abtg
 p3RDQfrpPULFjQvENtY6ug1z8nhb3vlo9ltjw3QUwpUTsH2wAK4gEkdAEUkqCl2TRAO/
 ijtg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1788939321; x=1789544121;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xcudaz2PnKA/xLelmlRmiE9DkpwYzgpiv7HoBDaaLig=;
 b=X6pWCz0b1MM3bLmXzFY657rmevsbx/Y4WwgqREj+c4TO6ppKu0ylF6lvQ3Ff/3VkG3
 GgXLo+aDAZZFccr1TS9p7F46PyZD3xF56aMFfAXoB+p3wCRvJWElwRFPxuPehZgUSnlI
 zr6R86wpm4b0S73B4KXK0/LEBCqsZkkCZr8v6FsPeuR+wXt/2v+akPuDbX0xduW97CaN
 9N7+l+i/U0glw+vKivOjgboBPNBBj5WFD7sViPCke9DFFtPol2whSrMcmUz08kuilWzU
 I3hO1fgrSPk664kMkdtg3DUQGmJJoBvGXxs4EBf89DNAsiqgJkBPBjqF3kXUu3ACMliG
 7igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788939321; x=1789544121;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xcudaz2PnKA/xLelmlRmiE9DkpwYzgpiv7HoBDaaLig=;
 b=ry2AoG+yPsTMs2oRFI6IdLCnw2ITwkLPw242/gFPnbP/7dSAgjKbFU/vcGg6Fiic8O
 H5m10tBsnns9MAIusT3mMeHM8cq64XRU28zM3Av+ZRN+kxdkVWMGgo3kR5AvWdBN9fO1
 JB2LMzLx2zLb22vUit1fquKqQiCTUXGsmQyL2oIoohYnCHyADQsoV2suQvH4ESUcqVMi
 NV12L7xGVvYqEaeKJzpWuL6sCrzhoGjBQbIdkc6DxJXPNJtXX2SoCDkUQ8NQ8Rk+qA/R
 fN+Ca1g8TadT23dF55uJyVRYSMEb9JoCGU9PzgKqsXyC9WyVud7Vcr5PygoYkhjO3KTM
 /D9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2RcN5+V6w367A/6JTlaK7cULguHOzyF38F1PGjH7yIWyqFeFKvK7UAUvPE1lOwb1XtaEFWW+9svw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPFbKDJCf9HYJsaK5AYZRrKX0qBtNNah6g2nTosuMBaLuHGmkt
 7/Nh+Xzs/NWoOL7HYrSQUF8YhylU0/blNqjB3IiJjFaK49FzZCta3O/0IxNU+0mVtgpBjydAxlR
 j0K2ugmT7GmTZc7t7ph1bsTDM0PpoXq3g7Ogm8Lbhug==
X-Gm-Gg: AYBFou2A/VCWATtUs4fd+yTN0ZUp0awJadHLW34+cg4QhvuQ6pdJbwb5Mu+lcvn8q9Q
 +CbC6yg6q+Fexmzi4UgbkmKGwWPlGxIvfK6e6an7F+B5/XFxZ0qIZn4vRAuVzIgX3cpYZYePMPD
 ltJQmTD2ZdjUHaTjReoHPIC+ozs46TDLu2XQXHqQXrmAItJRWC2TN02yUsKceJrdYErfE1QaJCV
 Idfz0ZUG/i0GeDzw3k05V3bAu3ikdd2NPnPXkBAt3dnRHuQFcH+k9L0gDNTHFgSfcwJHSFgcuuA
 +V9j+TsD/7INGLvuK5ONzGjeDKDGkWMEbuXDQkeSH5Qvt7s0kCZTwpqfq9ApFjvXJ/qe64hjHxW
 D+L2YGO/BgYE=
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id
 98e67ed59e1d1-39b262e28cdmr53270211a91.22.1788939321244; Wed, 09 Sep 2026
 00:35:21 -0700 (PDT)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 00:35:18 -0700
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 00:35:17 -0700
MIME-Version: 1.0 (Mimestream 1.10.6)
References: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
 <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
From: Ed Schofield <ed@aicharmers.com>
Date: Wed, 9 Sep 2026 00:35:18 -0700
X-Gm-Features: AcwNN1WidtaWaL_d2nYwEqMY0NJ1KL9WBgTWFom0Y8eq20p4ze6JFx_502bRDcg
Message-ID: <CA+8hrDiEn1Vo-fsP+nZCmbc_vr5hwRdKOvHOr6_YYGkiCgPNQA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Guna R . Bharati" <062bel313@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c4912f065b07e4f6"
X-Mailman-Approved-At: Wed, 09 Sep 2026 08:38:27 +0000
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

--000000000000c4912f065b07e4f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Kenneth, hi Atharva,

Thanks for bringing the two threads together. I've tried your suggestion on
my iMac20,1 (1002:7340 / 106b:0218, revision 0x41), with SMU firmware
53.38.0. Two warm boots both failed.

On the same AMD staging base as my RFC, I moved UCLK enablement to the
beginning of navi10_set_default_dpm_table(), along with the readback check
and supported-feature update. I removed the later enable and refresh from
post-init. UCLK was still excluded from enable-all, and both memory-voltage
features stayed the same. I didn't add any delay or extra mailbox tracing.

Both boots reported:

    SMU: No response msg_reg: 8 resp_reg: 0
    in params:00000008
    Apple 0218 default-table UCLK enable failed: -62

AMDGPU failed to bind in both cases. I checked that the experimental module
was loaded and the firmware files hadn't changed.

This also fits an earlier test with T2 7.1.8. With UCLK excluded from
enable-all, I tried enabling it separately immediately after
smu_v11_0_system_features_control(smu, true) returned successfully. The
trace shows EnableAllSmuFeatures returning 0x1, then EnableSmuFeaturesLow
with argument 0x8 timing out with response 0 and -ETIME.

The default-table function is reached only after enable-all returns
successfully, so waiting for that acknowledgement doesn't seem to be enough
on this board. I don't yet know whether it needs more time or some other
initialization step. I'd keep post-init for now: that version passed the
ten recorded AMD staging warm boots. These tests don't establish the
earliest safe point.

As for Apple, I can't speak for Apple or confirm their approval. I'm
testing this as a Linux user. Do we need Apple's input before merging an
Apple-specific workaround? If so, could AMD help find the right contact?
I'd still welcome a fix for the underlying firmware problem.

I agree we should coordinate the two patches. Mine covers only 0218/rev
0x41; Atharva's covers 0219. We'd still need to test the combined change on
both boards.

Thanks!
    Ed


On 9 Sep 2026 at 5:05:51=E2=80=AFpm, "Feng, Kenneth" <Kenneth.Feng@amd.com>=
 wrote:

> AMD General
>
> This issue is also addressed in the thread: [RFC PATCH] drm/amd/pm: defer
> UCLK DPM enablement on Apple Navi 14 0218.
> I think the workaround can be merged for Apple specifically between this
> patch and that patch from Ed Schofield.
> The same questions:
> 1. can this workaround setting be put right after the
> SMU_MSG_EnableAllSmuFeatures is acked?
> 2. Does Apple accept this workaround instead of a root cause on how
> SMU_MSG_EnableAllSmuFeatures is not acked back?
> Thanks.
>
>
> -----Original Message-----
> From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Sent: Tuesday, August 25, 2026 3:04 AM
> Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>; Guna R . Bharati <
> 062bel313@gmail.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <
> Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
> Vetter <simona@ffwll.ch>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
> 5300
>
> [You don't often get email from atharvatiwarilinuxdev@gmail.com. Learn
> why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On the AMD Radeon PRO 5300, enabling UCLK_BIT in
> navi10_init_allowed_features causes errors such as:
>
> SMU: No response msg_reg: 6 resp_reg: 0
>
> or:
>
> SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000006
> SMN_C2PMSG_82:0x00000000
>
> To work around this issue, we use smu_set_pp_feature_mask() to enable
> UCLK_BIT instead.
>
> Fixes:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/4895
>
> Tested-by: Guna R. Bharati <062bel313@gmail.com>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++++++
> .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  7 +++-
> 2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 3969a7670..c05ceb0be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -905,6 +905,33 @@ static int
> smu_apply_default_config_table_settings(struct smu_context *smu)
>        return smu_set_config_table(smu, &adev->pm.config_table);  }
>
> +static int smu_apply_late_quirks(struct smu_context *smu) {
> +       struct pci_dev *pdev =3D smu->adev->pdev;
> +       int ret =3D 0;
> +       uint32_t features[2];
> +       struct smu_feature_bits feature_mask;
> +       uint64_t mask;
> +
> +       if (pdev->device =3D=3D 0x7340 &&
> +                       pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE=
 &&
> +                       pdev->subsystem_device =3D=3D 0x0219) {
> +               ret =3D smu_feature_get_enabled_mask(smu, &feature_mask);
> +               if (ret)
> +                       return ret;
> +
> +               smu_feature_bits_to_arr32(&feature_mask, features, 64);
> +               features[0] |=3D BIT(3);
> +               mask =3D ((uint64_t)features[1] << 32) | features[0];
> +
> +               ret =3D smu_set_pp_feature_mask(smu, mask);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> static int smu_late_init(struct amdgpu_ip_block *ip_block)  {
>        struct amdgpu_device *adev =3D ip_block->adev; @@ -977,6 +1004,12 =
@@
> static int smu_late_init(struct amdgpu_ip_block *ip_block)
>
>        smu_restore_dpm_user_profile(smu);
>
> +       ret =3D smu_apply_late_quirks(smu);
> +       if (ret) {
> +               dev_err(adev->dev, "Unable to apply late quirks\n");
> +               return ret;
> +       }
> +
>        return 0;
> }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 6dfc3b585..ed67e4bfc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -349,7 +349,12 @@ navi10_init_allowed_features(struct smu_context *smu=
)
>              (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, =
0,
> 0)) &&
>              (adev->rev_id =3D=3D 0)) &&
>            (adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
> -               smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED,
> FEATURE_DPM_UCLK_BIT);
> +               if (!(adev->pdev->device =3D=3D 0x7340 &&
> +                               adev->pdev->subsystem_vendor =3D=3D
> PCI_VENDOR_ID_APPLE &&
> +                               adev->pdev->subsystem_device =3D=3D 0x021=
9))
> +                       smu_feature_list_set_bit(smu,
> SMU_FEATURE_LIST_ALLOWED,
> +                                       FEATURE_DPM_UCLK_BIT);
> +
>                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED,
> FEATURE_MEM_VDDCI_SCALING_BIT);
>                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED,
> FEATURE_MEM_MVDD_SCALING_BIT);
>        }
> --
> 2.43.0
>
>

--000000000000c4912f065b07e4f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"ltr">
    <div dir=3D"ltr">Hi Kenneth, hi Atharva,</div><div dir=3D"ltr"><br></di=
v><div dir=3D"ltr">Thanks for bringing the two threads together. I&#39;ve t=
ried your suggestion on my iMac20,1 (1002:7340 / 106b:0218, revision 0x41),=
 with SMU firmware 53.38.0. Two warm boots both failed.</div><div dir=3D"lt=
r"><br></div><div dir=3D"ltr">On the same AMD staging base as my RFC, I mov=
ed UCLK enablement to the beginning of navi10_set_default_dpm_table(), alon=
g with the readback check and supported-feature update. I removed the later=
 enable and refresh from post-init. UCLK was still excluded from enable-all=
, and both memory-voltage features stayed the same. I didn&#39;t add any de=
lay or extra mailbox tracing.</div><div dir=3D"ltr"><br></div><div dir=3D"l=
tr">Both boots reported:</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
=C2=A0 =C2=A0 SMU: No response msg_reg: 8 resp_reg: 0</div><div dir=3D"ltr"=
>=C2=A0 =C2=A0 in params:00000008</div><div dir=3D"ltr">=C2=A0 =C2=A0 Apple=
 0218 default-table UCLK enable failed: -62</div><div dir=3D"ltr"><br></div=
><div dir=3D"ltr">AMDGPU failed to bind in both cases. I checked that the e=
xperimental module was loaded and the firmware files hadn&#39;t changed.</d=
iv><div dir=3D"ltr"><br></div><div dir=3D"ltr">This also fits an earlier te=
st with T2 7.1.8. With UCLK excluded from enable-all, I tried enabling it s=
eparately immediately after smu_v11_0_system_features_control(smu, true) re=
turned successfully. The trace shows EnableAllSmuFeatures returning 0x1, th=
en EnableSmuFeaturesLow with argument 0x8 timing out with response 0 and -E=
TIME.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">The default-table fu=
nction is reached only after enable-all returns successfully, so waiting fo=
r that acknowledgement doesn&#39;t seem to be enough on this board. I don&#=
39;t yet know whether it needs more time or some other initialization step.=
 I&#39;d keep post-init for now: that version passed the ten recorded AMD s=
taging warm boots. These tests don&#39;t establish the earliest safe point.=
</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">As for Apple, I can&#39;t=
 speak for Apple or confirm their approval. I&#39;m testing this as a Linux=
 user. Do we need Apple&#39;s input before merging an Apple-specific workar=
ound? If so, could AMD help find the right contact? I&#39;d still welcome a=
 fix for the underlying firmware problem.</div><div dir=3D"ltr"><br></div><=
div dir=3D"ltr">I agree we should coordinate the two patches. Mine covers o=
nly 0218/rev 0x41; Atharva&#39;s covers 0219. We&#39;d still need to test t=
he combined change on both boards.</div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr">Thanks!</div><div dir=3D"ltr">=C2=A0 =C2=A0 Ed</div><div dir=3D"lt=
r"><br></div>
</div>
<br>
<div class=3D"gmail_quote">
    <div dir=3D"ltr" class=3D"gmail_attr">On 9 Sep 2026 at 5:05:51=E2=80=AF=
pm, &quot;Feng, Kenneth&quot; &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">K=
enneth.Feng@amd.com</a>&gt; wrote:<br></div>
    <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex" type=3D"cite">
       =20
<div>
<div>
    AMD General<br><br>This issue is also addressed in the thread: [RFC PAT=
CH] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14 0218.<br>I think=
 the workaround can be merged for Apple specifically between this patch and=
 that patch from Ed Schofield.<br>The same questions:<br>1. can this workar=
ound setting be put right after the SMU_MSG_EnableAllSmuFeatures is acked?<=
br>2. Does Apple accept this workaround instead of a root cause on how SMU_=
MSG_EnableAllSmuFeatures is not acked back?<br>Thanks.<br><br><br>-----Orig=
inal Message-----<br>From: Atharva Tiwari &lt;<a href=3D"mailto:atharvatiwa=
rilinuxdev@gmail.com">atharvatiwarilinuxdev@gmail.com</a>&gt;<br>Sent: Tues=
day, August 25, 2026 3:04 AM<br>Cc: Atharva Tiwari &lt;<a href=3D"mailto:at=
harvatiwarilinuxdev@gmail.com">atharvatiwarilinuxdev@gmail.com</a>&gt;; Gun=
a R . Bharati &lt;<a href=3D"mailto:062bel313@gmail.com">062bel313@gmail.co=
m</a>&gt;; Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">Kennet=
h.Feng@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<=
a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;=
; David Airlie &lt;<a href=3D"mailto:airlied@gmail.com">airlied@gmail.com</=
a>&gt;; Simona Vetter &lt;<a href=3D"mailto:simona@ffwll.ch">simona@ffwll.c=
h</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; <a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-=
devel@lists.freedesktop.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel=
.org">linux-kernel@vger.kernel.org</a><br>Subject: [PATCH] drm/amdgpu/smu: =
Enable UCLK after init in AMD Radeon Pro 5300<br><br>[You don&#39;t often g=
et email from <a href=3D"mailto:atharvatiwarilinuxdev@gmail.com">atharvatiw=
arilinuxdev@gmail.com</a>. Learn why this is important at <a href=3D"https:=
//aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIde=
ntification</a> ]<br><br>On the AMD Radeon PRO 5300, enabling UCLK_BIT in n=
avi10_init_allowed_features causes errors such as:<br><br>SMU: No response =
msg_reg: 6 resp_reg: 0<br><br>or:<br><br>SMU: I&#39;m not done with your pr=
evious command: SMN_C2PMSG_66:0x00000006 SMN_C2PMSG_82:0x00000000<br><br>To=
 work around this issue, we use smu_set_pp_feature_mask() to enable UCLK_BI=
T instead.<br><br>Fixes:<br><a href=3D"https://gitlab.freedesktop.org/drm/a=
md/-/work_items/4895">https://gitlab.freedesktop.org/drm/amd/-/work_items/4=
895</a><br><br>Tested-by: Guna R. Bharati &lt;<a href=3D"mailto:062bel313@g=
mail.com">062bel313@gmail.com</a>&gt;<br>Signed-off-by: Atharva Tiwari &lt;=
<a href=3D"mailto:atharvatiwarilinuxdev@gmail.com">atharvatiwarilinuxdev@gm=
ail.com</a>&gt;<br>---<br> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c =C2=A0=
=C2=A0=C2=A0=C2=A0| 33 +++++++++++++++++++<br> .../gpu/drm/amd/pm/swsmu/smu=
11/navi10_ppt.c =C2=A0=C2=A0| =C2=A07 +++-<br> 2 files changed, 39 insertio=
ns(+), 1 deletion(-)<br><br>diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgp=
u_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>index 3969a7670..c05=
ceb0be 100644<br>--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>+++ b/d=
rivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>@@ -905,6 +905,33 @@ static int=
 smu_apply_default_config_table_settings(struct smu_context *smu)<br> =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return smu_set_config_table(smu, &am=
p;adev-&gt;pm.config_table); =C2=A0}<br><br>+static int smu_apply_late_quir=
ks(struct smu_context *smu) {<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stru=
ct pci_dev *pdev =3D smu-&gt;adev-&gt;pdev;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0int ret =3D 0;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_=
t features[2];<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct smu_feature_=
bits feature_mask;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t mask;<=
br>+<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pdev-&gt;device =3D=3D 0x=
7340 &amp;&amp;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0pdev-&gt;subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &amp;&amp;<br>+ =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdev-&gt;subsystem_de=
vice =3D=3D 0x0219) {<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D smu_feature_get_enabled_mask(sm=
u, &amp;feature_mask);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)<br>+ =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;<br>+<br>+ =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smu_fe=
ature_bits_to_arr32(&amp;feature_mask, features, 64);<br>+ =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0featur=
es[0] |=3D BIT(3);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mask =3D ((uint64_t)features[1] &lt;&lt; 3=
2) | features[0];<br>+<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D smu_set_pp_feature_mask(smu,=
 mask);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (ret)<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=
<br>+<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;<br>+}<br>+<br> sta=
tic int smu_late_init(struct amdgpu_ip_block *ip_block) =C2=A0{<br> =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct amdgpu_device *adev =3D ip_block=
-&gt;adev; @@ -977,6 +1004,12 @@ static int smu_late_init(struct amdgpu_ip_=
block *ip_block)<br><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smu_rest=
ore_dpm_user_profile(smu);<br><br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
 =3D smu_apply_late_quirks(smu);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
f (ret) {<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(adev-&gt;dev, &quot;Unable to apply late qu=
irks\n&quot;);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0}<br>+<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;<br>=
 }<br><br>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>index 6dfc3b585..ed67e4bfc=
 100644<br>--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>+++ b/d=
rivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>@@ -349,7 +349,12 @@ navi=
10_init_allowed_features(struct smu_context *smu)<br> =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(amdgpu_ip_version=
(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp;<br> =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(adev-=
&gt;rev_id =3D=3D 0)) &amp;&amp;<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(adev-&gt;pm.pp_feature &amp; PP_MCLK_DPM_MAS=
K)) {<br>- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED=
, FEATURE_DPM_UCLK_BIT);<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(adev-&gt;pdev-&gt;device =3D=
=3D 0x7340 &amp;&amp;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adev-&gt;pdev-&gt;=
subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &amp;&amp;<br>+ =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0adev-&gt;pdev-&gt;subsystem_device =3D=3D 0x0219))<br>+ =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smu_feature_list_set_=
bit(smu, SMU_FEATURE_LIST_ALLOWED,<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0FEATURE_DPM_UCLK_BIT);<br>+<br=
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, F=
EATURE_MEM_VDDCI_SCALING_BIT);<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smu_feature_list_set_bit=
(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);<br> =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}<br>--<br>2.43.0<br><br>
</div>
</div>
    </blockquote>
</div></body></html>

--000000000000c4912f065b07e4f6--
