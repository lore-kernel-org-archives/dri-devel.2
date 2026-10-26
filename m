Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE44606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y1uzXT4s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M5zuiwWI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CAD10F1D6;
	Mon, 26 Oct 2026 23:28:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1466410F1D5
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:28:40 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QMOxg4351685
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=o+I2AzBdqLn39dfVG95T/n+D0wibJWJbOKJL+qKq03E=; b=Y1
 uzXT4s/NaOckjuhPCvanJCM72ZakvhgacqOIOG5CF3d7ytYsAYVWIs/DugT2Jji2
 JcQ3HyW94/UCBRH8nor5BcXg/Vk11qju23fFuR2vza95jRzZxd6pKFmik6oLMloC
 jDFLWeGqWKS7WEKniyBNpLg3etS5OZVzqXEgNxZXBNgkC+zBBiZqiBShyLY36mPU
 Tx0Dh3Dm9EaKsTpQpdbi+6uqV4kRdbX2v4XrZtCzuocXmWxJj2acYKOvqyr57bz7
 Q1nNHMrDJxvWRAWelkS7RyGrcbhoI4yQ6WX1tDwfwKiwVKDd9fSPVBlE+tQVNr+g
 TRaDuAGw/BtLa6zGsjjw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavr75d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 23:28:38 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4a68926c8c4so4230735fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793057318; cv=none;
 d=google.com; s=arc-20260327;
 b=qcI0mYTxa6snnsKhBBMTLoNr+UIcJbdVteedNVWnpiJBKNvlHFIm4BvEo7hr2+mPtd
 dajfMKcfmjnrlfzzOOV9AY7oa627J6jirdF18Fnt7DCjDXk/CEX/rzISIrE8TiLJXOK/
 /nud7CUbN3pDErWF/2ZSvBCXvRX2G6vuyCXS+qwtI2Sq6cgCz2qrDn7wtRCwrWP0QLrX
 4PVMAEtQl7+8BGyy7l9cvuZB2hKRYhbNLOuMEDdBYaeobE9tEhAp9M90c0VRcksZxjV3
 5Olsj2TuwaKVqv0AfDU7NIPUcIW+iTaZNMAPHOEu21x9mvoZ1ypNZVafaKQAdVAtmSlL
 TR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=o+I2AzBdqLn39dfVG95T/n+D0wibJWJbOKJL+qKq03E=;
 fh=2Ow/+l/TcamzIs7OuKRUmEHV0P87T0mt3ohxq/g2s4M=;
 b=LZklrYX8p1xz8c2dcM7JQQZ1LfxWFo5X0eE3OIXztsSW0hdZgUTA4iP1YM+sqO8ef7
 /pwoFd6Wgz28dUtDAHB3ueJBLvoIaHqaJBwJh3UuFo8dfaj0WVtwMyxbs3SliEJljtcP
 fwb6tG5xH3zJHhWOrLE+6BGTQK2fjGpjwBcQ2V7Sjp2dhqLVSHH+8vo0RMkl+luGD5c3
 R73GqjagJ5YI3hD6C2KF2UkRa2tjzG+MsaHDeg7DFdRXwEWkVZd+IP6qzmBOQseGiB7A
 uNmS8NLKKnAHfkyMBvV9OolW2UEYpSlHJSZ2JgWDKXRconei3DtZZAUrYqgTz1dl7mY8
 qlMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793057318; x=1793662118;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o+I2AzBdqLn39dfVG95T/n+D0wibJWJbOKJL+qKq03E=;
 b=M5zuiwWImBICsRdMHdDS/uWKTsQzFzRRAAsiIVN8fuI3FgR/lC5429yO5IqvCfe+kY
 B6uSKATrATTBSHBFtSSkT+a0vvKAK42jeTVe/WMRgT5v+4era6Bqu/rk9MuRkN7Pd9sx
 2Ok0kyBzL7qx7dUrRG+43F5BKMmDA4+yCCAPPqkZAWCQQLBD+pE9gMsa8rvIYeBE+agT
 Xqs95mt1sgrMJOc/kHVbl+2yru8LsSoeQehJDxd0TBuT28WaCYe9gAcPVwK3Mw/TZ2hy
 C9acCmdkxzjUNyXbVI2W1I+0tYkvSwYZMOS+M+dC5cU+uHM0OoRe6KzD+d/IeK1vuDKB
 OVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793057318; x=1793662118;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o+I2AzBdqLn39dfVG95T/n+D0wibJWJbOKJL+qKq03E=;
 b=KI4SiHZIR/6cUefoslShZJxBmcxLJVIGdma3sttL99IpGxWz0ojkXAOwTRAkOPfbfZ
 A9iYu/xbCaGA2a0BlpNnHBCl6DhDEqjQcGzLM6CZynHdorIY/ffXmhvWlj2t3sc72HLZ
 S2U92j17ZJ2aXmUiyDHeo9/ZD1Pgilvd0fMTh1s7KdkyzNagDhdoNa/u8TBF1W+8dA3u
 8Na8OxfUXhQZz2ZhiNb3SDAhRZIjgoqo2qDojkfu9uC5iKfpW/c063P/kZp5JQQYtaDs
 tkSn8yO12zq2KW71BxbOOCmJliXA0hRW3rnX1O+VL9haec0/SWE8KGKANzhRFe4IP0wo
 b1gA==
X-Gm-Message-State: AFq9FYLf1myOPTobIKaERlLBgoO4lWOwUF/Y12iS35wyRd6i0sjT4obJ
 7pIY41V7qm4XoRdRH2sFUpctJxThToF+PWUlWrhSMnsCXzVagItI1EwhHpP2Ecq5ck2jw0t6vnP
 HfH25h3jaPVgs9TlzfuRcdE2BSXrf0JhKPZz0Lv/+NUn44RJArwUpl7rmR/E5ovtSa/F4Vy4J6W
 MerXwUGr2U4xuIcyVf7N6kxQP/3ArpcbDasL9RxPjh/tTkfA==
X-Gm-Gg: AYBFou28Dl+cR5q95ugIV+pi/sWA3kjh+s4XVfLWi7OJI6a7Hp0aL1egun7d/bGX7PG
 x07hpXx+Gs1dXwJ+G1xq8VfnrR9z4wbBYoTxf059l+81yuAmVMh/3wfz12+nOg8ypVN0GKJvMnY
 LcdTuCocQdX5rMQEtRfMwWtqOyW/MhVE2zZeU6xMtneemSTpMP3rAk+H8lJA==
X-Received: by 2002:a05:6871:7513:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4a83f4a246bmr4938641fac.28.1793057317956; 
 Mon, 26 Oct 2026 16:28:37 -0700 (PDT)
X-Received: by 2002:a05:6871:7513:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4a83f4a246bmr4938635fac.28.1793057317392; Mon, 26 Oct 2026
 16:28:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <FZvwtKTpIxRNzjzcqFf6bTw12mNTJvJZmg6j9lmi8MehHBt91NogIW8oQd5yFHN5DSL8yIWL8p_b1cJPAJC57ZFkoe2BOAh_Y3kwph5SV_A=@pm.me>
In-Reply-To: <FZvwtKTpIxRNzjzcqFf6bTw12mNTJvJZmg6j9lmi8MehHBt91NogIW8oQd5yFHN5DSL8yIWL8p_b1cJPAJC57ZFkoe2BOAh_Y3kwph5SV_A=@pm.me>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:28:26 -0700
X-Gm-Features: AclHuK8vaIH6p9w0eeJAG1ndOcuOZrOVoVMEyv0y1BXqKWCwPIOx8bBDbK0rbpI
Message-ID: <CACSVV02x=GDTH40C57B1Eg8_CfmCgDGD_BE4f1auwFf=3eQNCg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] drm/msm/a8xx: GPU state capture support
To: Alexander Koskovich <akoskovich@pm.me>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: GPsTk1vheL7Dk-cJ0S3ThCoqbbAAMHA8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MyBTYWx0ZWRfXwKgcuZwyS/B0
 AZ/Sj8zgqvD4b7uKolb7ZKGauHeQfe+638XbjDgESRFRPzAt1rAU9qlCdEuhVrxCcFinOg2vvej
 bpeq6ScLtX3LCYNG3+or9AZkV1HOYSI=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6adfe226 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=oZfsDU2LrdIIkRBWPnYA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: GPsTk1vheL7Dk-cJ0S3ThCoqbbAAMHA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MyBTYWx0ZWRfXwkhgmQqN0lof
 0CyKBuSpsfeI6O/EIJxYcoD2gxpGZZCK3KBWakyO7ANPhJcmCMdX9yohNAk7KmBT432VPCH0nPF
 nXUdBjFxpknOsDgzaWNsTEZe9cqt8MOeddtljUSDTKfzWRPbGkTObOtvYTg2C7gXZc24OxP54tq
 fb6zXb7V9YSVNik7t8ueBNTYVvrkzPoe7d3rPmEIVRd4QaaPLRvoLj+b1Pp6AHdD6WGkbWEXKB0
 yeCdQBvFKt60VEAWw3gWCmoI1hS5n88oZ2kpGDAE8P/NTtWOL3xSgXfw9notrSdpPGzBVDsBemH
 VAFN0hjICvaEEK0o46hhVdxX7h+a/ShceTydEYFH4xA+AjKDzKyEJ+yF72ipXO0KBG+ytSDGeVU
 4HQ6a+UOAJ8oWA8uOoSbiCYcKJq+CoO571Aibtnpn3tY3de6hezqYpbRi8AdsUxEVF+FpVU5RhP
 FDLVYdLoC5umlQnEGYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260093
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 4:06=E2=80=AFPM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
> On Wednesday, October 21st, 2026 at 4:54 PM, Rob Clark <robin.clark@oss.q=
ualcomm.com> wrote:
> >
> > I'd appreciate tested-by's on Hawi, Maili, Milos, and Pakala, since I
> > don't have these devices at-hand to test myself.  In particular, do
> > things look fine after the switch to generated nonctx regs.  To test
> > devcoredump, you can use the msm_recovery test in igt.. or just:
> >
> >   cat /sys/kernel/debug/dri/*/gpu > /dev/null
> >
>
> Tested this series on Milos, series as is works fine for initial boot, na=
vigating
> around GNOME & apps etc, but when I run 'cat /sys/kernel/debug/dri/*/gpu'=
, run
> into an oops.
>
> That is resolved after removing 0x20400-0x20487 from milos_gmucx_register=
s,
> and removing 0x0f000-0x0f002 from milos_cp_cp_pipe_none_registers. Not su=
re
> if access to these is restricted by TZ or something isn't configured righ=
t?
> These ranges don't seem to be described downstream in adreno_gen8_3_0_sna=
pshot.h.

Thanks, yeah, there seems to be some things blocked by
tz/hyp/something, which are not blocked on glymur/el2.  I'll have a v3
soon, but still chasing down some of these details.

>
> After that 'cat /sys/kernel/debug/dri/*/gpu' works and I get a dump, did =
observe these errors in dmesg after though:
>
> [   42.891106] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891142] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891157] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891171] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891184] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891198] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891211] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891224] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891237] platform 3d6c000.gmu: GMU fence error: 0x0
> [   42.891250] platform 3d6c000.gmu: GMU fence error: 0x0
> [   43.640122] ------------[ cut here ]------------
> [   43.640137] msm_dpu ae01000.display-controller: [drm] crashdumper time=
d out: status=3D5c00bd00 (-110)
> [   43.640222] WARNING: drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:115 a=
t CD_RUN+0x20c/0x594 [msm], CPU#3: cat/1929
> [   43.640419] Modules linked in: rfcomm q6apm_dai q6prm_clocks q6apm_lpa=
ss_dais snd_q6dsp_common q6prm algif_hash algif_skcipher bnep snd_q6apm pan=
el_raydium_rm69220 fastrpc qcom_pd_mapper ath11k_ahb ath11k mac80211 hci_ua=
rt btqca bluetooth qcom_iris cfg80211 ecdh_generic msm ledtrig_pattern vide=
obuf2_dma_contig ecc v4l2_mem2mem drm_dp_aux_bus videobuf2_memops qcom_q6v5=
_pas ocmem qcom_pil_info videobuf2_v4l2 pwrseq_qcom_wcn gpu_sched ipa pwrse=
q_core qmi_tmd focaltech_ft3683g qcom_q6v5 drm_gpuvm videobuf2_common drm_e=
xec rfkill drm_display_helper ubwc_config cec qcom_common mdt_loader libarc=
4 nft_reject_inet nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_ct nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables uhid fuse usb_f_ncm u_ether spi=
_geni_qcom evdev libcomposite
> [   43.640750] CPU: 3 UID: 0 PID: 1929 Comm: cat Tainted: G S            =
       7.3.0-next-20261026 #3 PREEMPT(full)
> [   43.640763] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [   43.640770] Hardware name: Nothing Phone (3a) (DT)
> [   43.640778] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [   43.640787] pc : CD_RUN+0x20c/0x594 [msm]
> [   43.640972] lr : CD_RUN+0x208/0x594 [msm]
> [   43.641155] sp : ffff8000891c3990
> [   43.641161] x29: ffff8000891c3990 x28: ffffc3ee34aef850 x27: ffff00080=
9253000
> [   43.641180] x26: 0000000000000001 x25: 0000000000000001 x24: 000000000=
0000020
> [   43.641198] x23: 0000000000000000 x22: 0000000000000000 x21: 000000000=
0002114
> [   43.641216] x20: 0000000a28796b5c x19: ffff000813d7f000 x18: ffff80008=
91ad078
> [   43.641233] x17: 3a74756f2064656d x16: 6974207265706d75 x15: 646873617=
263205d
> [   43.641250] x14: 3fffffffffffefff x13: 0000000000000003 x12: ffffc3ee5=
c6649c0
> [   43.641267] x11: 3fffffffffffefff x10: 0000000000000003 x9 : 9e14538c7=
7bb2600
> [   43.641284] x8 : 9e14538c77bb2600 x7 : 2e30303031306561 x6 : 207570645=
f6d736d
> [   43.641301] x5 : ffffc3ee5cb061bf x4 : 0000000000000345 x3 : 000000000=
0000000
> [   43.641318] x2 : 0000000000000000 x1 : ffff8000891c3790 x0 : 00000000f=
fffff92
> [   43.641336] Call trace:
> [   43.641343]  CD_RUN+0x20c/0x594 [msm] (P)
> [   43.641530]  a8xx_gpu_state_get+0xdc4/0x2698 [msm]
> [   43.641714]  msm_gpu_open+0xc0/0x134 [msm]
> [   43.641898]  full_proxy_open_regular+0xe0/0x1e8
> [   43.641913]  do_dentry_open+0x154/0x4d8
> [   43.641927]  vfs_open_consume+0x40/0x114
> [   43.641939]  path_openat+0x440/0x6a0
> [   43.641950]  do_file_open+0xdc/0x198
> [   43.641960]  do_sys_openat2+0x88/0x118
> [   43.641972]  __arm64_sys_openat+0x78/0xac
> [   43.641985]  invoke_syscall+0x6c/0x12c
> [   43.641997]  el0_svc_common+0x98/0xf0
> [   43.642007]  do_el0_svc+0x28/0x38
> [   43.642016]  el0_svc+0x4c/0x1ac
> [   43.642031]  el0t_64_sync_handler+0x6c/0xe4
> [   43.642043]  el0t_64_sync+0x1a0/0x1a4
> [   43.642056] ---[ end trace 0000000000000000 ]---

Hmm, not sure about this, other than maybe whatever is causing GMU
fence errors is also causing the timeout?

If you run something that keeps the gpu active (or disable ifpc), does
that help?

BR,
-R
