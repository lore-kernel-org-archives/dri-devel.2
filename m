Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC7606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=JMxy3ERP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29AE10E0A2;
	Tue, 27 Oct 2026 00:03:56 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF23710E0A2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1793059423; x=1793318623;
 bh=kueKbL7z9iLzTPubbIyuThS9hTpuVK3Jg4WyfhBW8ak=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JMxy3ERPAIfQaKuK7uM4547GcFAgiaOQ91z9zf1U+3+CykIHrJVS9F6X0DHyV5g3D
 0N26K7bu+Wli+qvJQ964pAunc8/u1x07uDewGivBJmrD5Omj75Cq1B8i9rkOiSokUD
 DG0sitYc3MRkOyv/bW6IW6o3FLK0iMPXOigP5fDXTqtdBq1S8Ad/32wpmzW+k+1Q50
 IqiU2eDqfNGHwyXnho+xG1ynSvZ9uoRMb7YMKl2w1Qkdb+ta0OVJpTUwC+6CTAKBQI
 w3sMGuGSqirW6i9Ot8GJqPJ8SxEzG+BSfFMbMeQa+PjzUOKxmDz4OIOBdE2FQiU28n
 bGwUWb8KGr1Lg==
Date: Tue, 27 Oct 2026 00:03:40 +0000
To: rob.clark@oss.qualcomm.com
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 00/14] drm/msm/a8xx: GPU state capture support
Message-ID: <HWs63_U2peTA6inCaYP8yY8D5MkYQ_f3KzN9-WXHzURewlVA-7MMJwkLffTUASri-OqRHtp0PI8PFdyUku_7PGxBaEyUbHda176jExmf2bo=@pm.me>
In-Reply-To: <CACSVV02x=GDTH40C57B1Eg8_CfmCgDGD_BE4f1auwFf=3eQNCg@mail.gmail.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <FZvwtKTpIxRNzjzcqFf6bTw12mNTJvJZmg6j9lmi8MehHBt91NogIW8oQd5yFHN5DSL8yIWL8p_b1cJPAJC57ZFkoe2BOAh_Y3kwph5SV_A=@pm.me>
 <CACSVV02x=GDTH40C57B1Eg8_CfmCgDGD_BE4f1auwFf=3eQNCg@mail.gmail.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 720cc2e5cb292645419ebbeacaaf8b15780fbbbb
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Monday, October 26th, 2026 at 7:32 PM, Rob Clark <rob.clark@oss.qualcomm=
.com> wrote:

> On Mon, Oct 26, 2026 at 4:06=E2=80=AFPM Alexander Koskovich <akoskovich@p=
m.me> wrote:
> >
> > On Wednesday, October 21st, 2026 at 4:54 PM, Rob Clark <robin.clark@oss=
.qualcomm.com> wrote:
> > >
> > > I'd appreciate tested-by's on Hawi, Maili, Milos, and Pakala, since I
> > > don't have these devices at-hand to test myself.  In particular, do
> > > things look fine after the switch to generated nonctx regs.  To test
> > > devcoredump, you can use the msm_recovery test in igt.. or just:
> > >
> > >   cat /sys/kernel/debug/dri/*/gpu > /dev/null
> > >
> >
> > Tested this series on Milos, series as is works fine for initial boot, =
navigating
> > around GNOME & apps etc, but when I run 'cat /sys/kernel/debug/dri/*/gp=
u', run
> > into an oops.
> >
> > That is resolved after removing 0x20400-0x20487 from milos_gmucx_regist=
ers,
> > and removing 0x0f000-0x0f002 from milos_cp_cp_pipe_none_registers. Not =
sure
> > if access to these is restricted by TZ or something isn't configured ri=
ght?
> > These ranges don't seem to be described downstream in adreno_gen8_3_0_s=
napshot.h.
>=20
> Thanks, yeah, there seems to be some things blocked by
> tz/hyp/something, which are not blocked on glymur/el2.  I'll have a v3
> soon, but still chasing down some of these details.
>=20
> >
> > After that 'cat /sys/kernel/debug/dri/*/gpu' works and I get a dump, di=
d observe these errors in dmesg after though:
> >
> > [   42.891106] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891142] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891157] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891171] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891184] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891198] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891211] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891224] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891237] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   42.891250] platform 3d6c000.gmu: GMU fence error: 0x0
> > [   43.640122] ------------[ cut here ]------------
> > [   43.640137] msm_dpu ae01000.display-controller: [drm] crashdumper ti=
med out: status=3D5c00bd00 (-110)
> > [   43.640222] WARNING: drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:115=
 at CD_RUN+0x20c/0x594 [msm], CPU#3: cat/1929
> > [   43.640419] Modules linked in: rfcomm q6apm_dai q6prm_clocks q6apm_l=
pass_dais snd_q6dsp_common q6prm algif_hash algif_skcipher bnep snd_q6apm p=
anel_raydium_rm69220 fastrpc qcom_pd_mapper ath11k_ahb ath11k mac80211 hci_=
uart btqca bluetooth qcom_iris cfg80211 ecdh_generic msm ledtrig_pattern vi=
deobuf2_dma_contig ecc v4l2_mem2mem drm_dp_aux_bus videobuf2_memops qcom_q6=
v5_pas ocmem qcom_pil_info videobuf2_v4l2 pwrseq_qcom_wcn gpu_sched ipa pwr=
seq_core qmi_tmd focaltech_ft3683g qcom_q6v5 drm_gpuvm videobuf2_common drm=
_exec rfkill drm_display_helper ubwc_config cec qcom_common mdt_loader liba=
rc4 nft_reject_inet nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_ct nf_conn=
track nf_defrag_ipv6 nf_defrag_ipv4 nf_tables uhid fuse usb_f_ncm u_ether s=
pi_geni_qcom evdev libcomposite
> > [   43.640750] CPU: 3 UID: 0 PID: 1929 Comm: cat Tainted: G S          =
         7.3.0-next-20261026 #3 PREEMPT(full)
> > [   43.640763] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [   43.640770] Hardware name: Nothing Phone (3a) (DT)
> > [   43.640778] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [   43.640787] pc : CD_RUN+0x20c/0x594 [msm]
> > [   43.640972] lr : CD_RUN+0x208/0x594 [msm]
> > [   43.641155] sp : ffff8000891c3990
> > [   43.641161] x29: ffff8000891c3990 x28: ffffc3ee34aef850 x27: ffff000=
809253000
> > [   43.641180] x26: 0000000000000001 x25: 0000000000000001 x24: 0000000=
000000020
> > [   43.641198] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000=
000002114
> > [   43.641216] x20: 0000000a28796b5c x19: ffff000813d7f000 x18: ffff800=
0891ad078
> > [   43.641233] x17: 3a74756f2064656d x16: 6974207265706d75 x15: 6468736=
17263205d
> > [   43.641250] x14: 3fffffffffffefff x13: 0000000000000003 x12: ffffc3e=
e5c6649c0
> > [   43.641267] x11: 3fffffffffffefff x10: 0000000000000003 x9 : 9e14538=
c77bb2600
> > [   43.641284] x8 : 9e14538c77bb2600 x7 : 2e30303031306561 x6 : 2075706=
45f6d736d
> > [   43.641301] x5 : ffffc3ee5cb061bf x4 : 0000000000000345 x3 : 0000000=
000000000
> > [   43.641318] x2 : 0000000000000000 x1 : ffff8000891c3790 x0 : 0000000=
0ffffff92
> > [   43.641336] Call trace:
> > [   43.641343]  CD_RUN+0x20c/0x594 [msm] (P)
> > [   43.641530]  a8xx_gpu_state_get+0xdc4/0x2698 [msm]
> > [   43.641714]  msm_gpu_open+0xc0/0x134 [msm]
> > [   43.641898]  full_proxy_open_regular+0xe0/0x1e8
> > [   43.641913]  do_dentry_open+0x154/0x4d8
> > [   43.641927]  vfs_open_consume+0x40/0x114
> > [   43.641939]  path_openat+0x440/0x6a0
> > [   43.641950]  do_file_open+0xdc/0x198
> > [   43.641960]  do_sys_openat2+0x88/0x118
> > [   43.641972]  __arm64_sys_openat+0x78/0xac
> > [   43.641985]  invoke_syscall+0x6c/0x12c
> > [   43.641997]  el0_svc_common+0x98/0xf0
> > [   43.642007]  do_el0_svc+0x28/0x38
> > [   43.642016]  el0_svc+0x4c/0x1ac
> > [   43.642031]  el0t_64_sync_handler+0x6c/0xe4
> > [   43.642043]  el0t_64_sync+0x1a0/0x1a4
> > [   43.642056] ---[ end trace 0000000000000000 ]---
>=20
> Hmm, not sure about this, other than maybe whatever is causing GMU
> fence errors is also causing the timeout?
>=20
> If you run something that keeps the gpu active (or disable ifpc), does
> that help?

Keeping GPU active doesn't seem to matter, get the fence errors either way.
Though, if I disable IFPC then they go away.

>=20
> BR,
> -R
>=20

Thanks,
Alex

