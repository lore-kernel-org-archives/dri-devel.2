Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFF606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZaPH5Ct9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IK3pKjtW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE7110F6C6;
	Tue,  3 Nov 2026 20:16:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D85A10F812
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:15:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZ0lp3675764
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 20:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=fQWmdcDL6Cf0p4F02BPbXYU/2SPFqbcTZjVM7RMBUmw=; b=Za
 PH5Ct9rMcuWBkD+H2gWQlyz38rtjVVrYO4AHgV2zsbg38FreAcDRdEt7zpNH1chS
 YfP0IcFcZ0NiqXeFdbF1zeonKVgDZbWOr7ibIfhIsZCdkWNX6Rq04rdK3pkycJPa
 rWCf+m/tLl0gppfje56ijvt4AdPS12VrX0v9HW6Cjmrn0OYIQGy9DRdMDSGro04E
 MGotj2mK9sy+3qzgDzMg57ItKaGM4bWNifuYN0IVp+j0imiGV30Edx7yux+ugVQ7
 w/S6JVcBXOxYX4ucvergODA/1l+xbDRhCQi/PJWkoZbvPYfptyf1+bL8+BLBxgjJ
 9WFXGTmpNBSPwXHOx2Tw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyphf5n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 20:15:48 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-45952ce9ee0so65778fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 12:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793736948; cv=none;
 d=google.com; s=arc-20260327;
 b=kQIi2Dqllp1//v71UOEytSwFNPGRCd3Q3TPEaxAFXf1G2wz7iUPoUbwwBoDJznnqDE
 63+QgA27nfwfqK1w2AG7tez7zZEOOlPubtPZ5prhdFhxaTkx6wtoh7PQuUt6nQnuhmG3
 9Emc78kf2qKJim/CybHy65eq97dq/OOnnRw7aA9a8XFoyf53ReVHk5WJ2SQ7UJvVZuJX
 obpoxr1g6kX+xbQb2atVbJylszXE5TKQaBm0LmVdm59eUVJakgdUzrptghxuiyAQTLgj
 r/91Htv4Qbv/fSjHs2sWtvYF1fc4pY2PjpiTvzk14UAAzXheALCk2pRsBOYvvQb3HONP
 4IpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fQWmdcDL6Cf0p4F02BPbXYU/2SPFqbcTZjVM7RMBUmw=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=Blpsm7zrAAI+EoV9AO8kY2JLR1W/D77Pj+l5fMxVDzdVbhaKC25AncM173C/87kYFh
 9Dvvn14FNDgXxtHMO0LN9cEYYpK1MaFjLWCIEcoPy1ojdfSbkbdBQKAZzS5i1DueDcos
 pkQSdjsiSKUFr+Be3xx4BkhH6yhIPYuNwvSvh15P0hmOP92hbYQ8eS5XLd/LT0VscPUJ
 tcY3cvrO0HdDxgmgHOuk9c/8OzXY7egM5ujoMjdpSDBnfi60T2nuf+3EXeOrkgBM/URb
 cju2errb/oiHiqxWR3rlCtDG4r8/dU+DSZCDhjwcDkyU9tCFrTIshXy+Juk2F9Z47hGt
 0KpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793736948; x=1794341748;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fQWmdcDL6Cf0p4F02BPbXYU/2SPFqbcTZjVM7RMBUmw=;
 b=IK3pKjtWBUC+vT1nj6vlCVUP3tmWuC3o2Z3R1cbBQU3ubvfjsF5fidliiN3/kv/CF2
 NKD/16QQ/EKeNHGcCEn2Zj4JnXSzPjuW9Pxn96JpslosO4uG4+muWnuxCTOXCdizCmyh
 MjWqmbeDGhJzpTewYZHYwIHXqvqWV9stNwaHhWiVE8MqcwgjA5cd0/H0cIxzUAsZA48i
 N2rwyOfA78rA0oe+sOlfEyO6tleHcP9FKy5+Z2TQyfQfl/G5QyAEqY3zTdCmhFo7RlUQ
 yqGRKhJGSfj9bLbejTUO2afu6MimPVIsbbbJLtM6rlvBXEHg7JxZqcNh7M8yfDeqc1Cv
 m4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736948; x=1794341748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fQWmdcDL6Cf0p4F02BPbXYU/2SPFqbcTZjVM7RMBUmw=;
 b=KWQZTFUK7qV1a79lvDpMFwdFHva3PdLwoADL9ZZqb1WJDVocblC9BVWxf62jS09cu9
 YswfDxRAcRyHygVmBnvna17vQIPeG1i18Qfg/vtlpgQIuPD7hdW3gu6SENvOFmVy4gze
 tb/fu2e6QtWjqao4j83GYMDQhVqGDPFU8zsmBxrkTx/gVfsa7sZA76a5dgjx6RQZtfEG
 dDiN8SWkq4N3btlMZLtbsg7bpSzKgKjZvEsVjO7VoCbZpN6eGMeqy88FsZZe4JpcAvwl
 5xJA1E776pbaMw1K2snBarB0u55Pt1/xm7klwpMkyNqVMIEUfPPwO781kFtTyZKS+840
 dtIg==
X-Gm-Message-State: APuU4Z+TuKo73wMgi8peBdW6grdBKL2U0jiWo5b1XkCKbry29aWrEo8g
 hL/MQ3xfNxGaku5RUC+K3HgNkLut7csJmkKIIDwyLRjXoQcK87RQkZtZ41maESpPSiH8wHh8R84
 WUmK7Bkqw56s8Hc1OqArZHWKwZ4F+9XrbSjQtUcx9DpduUwf82W3Ajr/rOl0OLtu8izCtQwRBaW
 SexmFtdUnHVviLgxOsUPx25+gRPv0fWJt9+Prrsq/v1m95nZVXUIhOsQ==
X-Gm-Gg: AYBFou3ZnCRvm0juGRULBbQp8MFB3FPPjIJgdtvP7TamSZIdvrji7N7gWhp0I6Dmckv
 ii1c2fTT/Q7XvPwXzuc+XBtvKARHTLy27ktcwl7xpDVxEmbDLh3H12Olrv3ooCdZ3VUITEnGHnr
 ASfBvt7YNNwaQLmww2uzFcjDEmru/D5QX5DaRSOJFa/Ur+QnFvcJeblYxZocAB56Qq1sAJdoGs5
 D+6N8T/TAeV+xHEM/LGpw==
X-Received: by 2002:a05:6871:a86d:b0:4a2:c175:d339 with SMTP id
 586e51a60fabf-4a90775b604mr8932180fac.39.1793736948064; 
 Tue, 03 Nov 2026 12:15:48 -0800 (PST)
X-Received: by 2002:a05:6871:a86d:b0:4a2:c175:d339 with SMTP id
 586e51a60fabf-4a90775b604mr8932146fac.39.1793736947335; Tue, 03 Nov 2026
 12:15:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
 <20261102220405.30730-12-robin.clark@oss.qualcomm.com>
 <sashiko-outbox-194286@kernel.org>
In-Reply-To: <sashiko-outbox-194286@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:15:36 -0800
X-Gm-Features: AclHuK9jHJl9ylHYf3aDmzOLPgH6YYGiep-CC-qpTd6jOhNr1FgWOibe_0bIeEE
Message-ID: <CACSVV01czyX=pVrX2Pq3V4W1rWV_sDNomwGLnBDxrbCqwYpP2w@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] drm/msm/a8xx: devcoredump state capture support
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXyS1jfUx6r+jH
 sa+gPyxXuXZp8tbyDyWyzxlKOMlqKL0hQBR0Qt4CUc/IQOPbQuxHg8smxPcBa+NkaXM0mbiNT9B
 FrEHrp9GeLHqYtzc1Bm2OXoeXF30v50=
X-Proofpoint-ORIG-GUID: c1srjyeKFaRIh0h7BrWHgCaFXWYnTd7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX0/0XzUU+zqbD
 0f9JmYDuhJcZMdjpDLIAfOzO9vb65Zit8sIjOjaGS44erv8QJEoTOl53cZbpTMWsjR6mYr7z+5k
 6pSGpV7cyLvMX4lvfSKdc9hl7eREKA6Y8Ur8gDXbRAPodUROriDHEYlkO34/odBsOWNAYi/ROIg
 6IFfgZKon/KwpmJVMHjF3BFqUit2xOq+y4PMSPWWeqkG6oevogp7XlwEDnQfI0LRLhtGGjBbshC
 zHQdLCqs1YZd350AHCBHadgTtZxB2yX7n8Zr5OuOjNYjnfEpU3rXTVnTrSDQTBAiFbKWHSglxJ5
 oX4DywScDL9P+22RtbQEGnqY4YtVbU6DQqOCQCiACYGpZjefIjcYBSyfKC8dcEVe8nDOePSaz5n
 nr9f4xVbgIc23+CE3hPVFWAoydp+B7wEfk4nQQ2FP+Q9S9Vb8n+k/8QWCfBrrqsDusWKg1gy7hO
 A5j8nu+EYyvuoEW1Mkw==
X-Proofpoint-GUID: c1srjyeKFaRIh0h7BrWHgCaFXWYnTd7m
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aea40f5 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8
 a=X5UkEppQgMmih3U4cmcA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 2:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] drm/msm/a8xx: wrong GX power check helper in a8xx_gpu_state_get(=
)
> - [High] drm/msm/a8xx: invalid slice 0 access in gen8_snapshot_mempool()
> - [High] drm/msm/a8xx: unguarded preempt_bo loop in a8xx_gpu_state_get() =
causes UAF
> - [Medium] drm/msm/a8xx: dirty CP_APERTURE_CNTL_HOST state in a8xx_gpu_st=
ate_get()
> --
>
> commit c7a029a7073f0aadd364139ec43ceeb070ef9dae
> Author: Rob Clark <robin.clark@oss.qualcomm.com>
>
> drm/msm/a8xx: devcoredump state capture support
>
> This commit adds devcoredump GPU state capture support for Adreno A8xx GP=
Us,
> including register lists, indexed registers, mempool, MVC clusters, shade=
r
> blocks, debugbus, and GMU state.
>
> > diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/=
drm/msm/adreno/a8xx_gpu_state.c
> > new file mode 100644
> > index 0000000000000..b75de2370e2e3
> > --- /dev/null
> > +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
>
> [ ... ]
>
> > +static void gen8_legacy_snapshot_registers(struct msm_gpu *gpu,
> > +                                        struct adreno_gpu_state *state=
,
> > +                                        const struct gen8_reg_list *re=
gs,
> > +                                        u32 slice_id)
> > +{
> > +     int count;
> > +
> > +     /* Figure out how many registers we are going to dump */
> > +     count =3D adreno_snapshot_regs_count(regs->regs);
> > +
> > +     snapshot_sect (state, MVC_V3, 4 * count, {
> > +             .ctxt_id =3D 0,
> > +             .cluster_id =3D CLUSTER_NONE,
> > +             .pipe_id =3D PIPE_NONE,
> > +             .location_id =3D UINT_MAX,
> > +             .sp_id =3D UINT_MAX,
> > +             .usptp_id =3D UINT_MAX,
> > +             .slice_id =3D HEADER_SLICE_ID(regs->slice_region, slice_i=
d),
> > +     }) {
> > +             unsigned long flags;
> > +
> > +             if (regs->sel)
> > +                     gpu_write(gpu, regs->sel->host_reg, regs->sel->va=
l);
> > +
> > +             if (regs->slice_region) {
> > +                     u32 val =3D GEN8_CP_APERTURE_REG_VAL(slice_id, 0,=
 0, 0);
> > +                     a8xx_aperture_acquire_raw(gpu, val, &flags);
> > +             }
> > +
> > +             /* Make sure the previous writes are posted before readin=
g */
> > +             mb();
> > +
> > +             for (const u32 *ptr =3D regs->regs; ptr[0] !=3D UINT_MAX;=
 ptr +=3D 2) {
> > +                     snapshot_mvc_regs_v3_subheader(&sect, ptr);
> > +
> > +                     for (int k =3D ptr[0]; k <=3D ptr[1]; k++) {
> > +                             snapshot_sect_u32(&sect, reg_read(gpu, k)=
);
> > +                     }
> > +             }
> > +
> > +             if (regs->slice_region)
> > +                     a8xx_aperture_release(gpu, flags);
> > +     }
> > +}
>
> [Severity: Medium]
> As reported by Sashiko on v4 [1], can gen8_legacy_snapshot_registers() le=
ave
> REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture programmed t=
o a
> previous slice when reading subsequent UNSLICE register blocks?
>
> In drivers/gpu/drm/msm/adreno/a8xx_gpu.c, a8xx_aperture_acquire_raw() wri=
tes
> to REG_A8XX_CP_APERTURE_CNTL_HOST and updates a6xx_gpu->cached_aperture,
> whereas a8xx_aperture_release() only drops a6xx_gpu->aperture_lock:
>
> drivers/gpu/drm/msm/adreno/a8xx_gpu.c:a8xx_aperture_release() {
>         spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
> }
>
> Because gen8_legacy_snapshot_registers() only calls
> a8xx_aperture_acquire_raw() when regs->slice_region is SLICE and does not
> clear the aperture afterward, when b->pre_crashdumper_regs or b->reg_list=
 has
> SLICE entries followed by UNSLICE entries, the UNSLICE entries are read w=
hile
> REG_A8XX_CP_APERTURE_CNTL_HOST still has A8XX_CP_APERTURE_CNTL_HOST_USESL=
ICEID
> and the previous slice_id set.
>
> In addition, regs->sel->host_reg is written before a8xx_aperture_acquire_=
raw()
> selects the target slice and outside aperture_lock, and a8xx_gpu_state_ge=
t()
> exits via the out label without calling a8xx_aperture_clear(gpu) to reset
> REG_A8XX_CP_APERTURE_CNTL_HOST and a6xx_gpu->cached_aperture after
> gen8_snapshot_mvc_regs(), gen8_snapshot_cp_indexed_regs(), and
> gen8_legacy_snapshot_registers() run.
>
> Should gen8_legacy_snapshot_registers() program the aperture for both SLI=
CE
> and UNSLICE regions (and write regs->sel->host_reg after acquiring the
> aperture), and should a8xx_gpu_state_get() call a8xx_aperture_clear(gpu) =
at
> the out label?

This is fine, reading UNSLICE regs does not depend on the aperture.
And USESLICEID only matters for writes, it controls whether the write
is broadcast to all slices or not.

This also matches kgsl.

> [ ... ]
>
> > +static bool gen8_snapshot_mempool(struct msm_gpu *gpu,
> > +                               struct adreno_gpu_state *state,
> > +                               struct adreno_crashdumper *dumper)
> > +{
> > +     const struct gen8_snapshot_block_list *b =3D block_list(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(to_adreno_gpu(gpu));
> > +     u32 slice_mask =3D a6xx_gpu->slice_mask;
> > +     u32 first_slice =3D a8xx_get_first_slice(a6xx_gpu);
> > +     bool ret =3D true;
> > +
> > +     for (int i =3D 0; i < b->mempool_index_registers_len && ret; i++)=
 {
> > +             const struct gen8_cp_indexed_reg *cp_indexed_reg =3D
> > +                     &b->mempool_index_registers[i];
> > +             unsigned long flags;
> > +             u32 j;
> > +
> > +             FOR_EACH_SLICE (j, cp_indexed_reg->slice_region, slice_ma=
sk) {
> > +                     u32 pipe_id =3D cp_indexed_reg->pipe_id;
> > +
> > +                     /* Set CP_CHICKEN_DBG[StabilizeMVC] to stabilize =
it while dumping */
> > +                     a8xx_aperture_acquire_raw(gpu,
> > +                             GEN8_CP_APERTURE_REG_VAL_NS(first_slice, =
pipe_id, 0, 0),
> > +                             &flags);
> > +                     gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2)=
, BIT(2));
> > +                     a8xx_aperture_release(gpu, flags);
> > +
> > +                     a8xx_aperture_acquire_raw(gpu,
> > +                             GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0=
),
> > +                             &flags);
> > +                     gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, =
BIT(2), BIT(2));
> > +                     a8xx_aperture_release(gpu, flags);
> > +
> > +                     ret =3D gen8_snapshot_indexed_registers(gpu, stat=
e, dumper,
> > +                             cp_indexed_reg->addr,
> > +                             cp_indexed_reg->data, 0,
> > +                             cp_indexed_reg->size,
> > +                             cp_indexed_reg->pipe_id,
> > +                             HEADER_SLICE_ID(cp_indexed_reg->slice_reg=
ion, j));
> > +
> > +                     /* Reset CP_CHICKEN_DBG[StabilizeMVC] once we are=
 done */
> > +                     a8xx_aperture_acquire_raw(gpu,
> > +                             GEN8_CP_APERTURE_REG_VAL_NS(first_slice, =
pipe_id, 0, 0),
> > +                             &flags);
> > +                     gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2)=
, 0);
> > +                     a8xx_aperture_release(gpu, flags);
> > +
> > +                     a8xx_aperture_acquire_raw(gpu,
> > +                             GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0=
),
> > +                             &flags);
> > +                     gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, =
BIT(2), 0);
> > +                     a8xx_aperture_release(gpu, flags);
> > +
> > +                     if (!ret)
> > +                             break;
> > +             }
> > +     }
>
> [Severity: High]
> As reported by Sashiko on v4 [2], does gen8_snapshot_mempool() access sli=
ce 0
> even when cp_indexed_reg->slice_region is UNSLICE and slice 0 is fused of=
f in
> slice_mask?
>
> For UNSLICE entries in b->mempool_index_registers, FIRST_SLICE(UNSLICE,
> slice_mask) sets j to 0 regardless of slice_mask:
>
> #define FIRST_SLICE(_region, _slice_mask) \
>         ((_region =3D=3D UNSLICE) ? 0 : NEXT_SLICE(0, _region, _slice_mas=
k))
>
> Inside FOR_EACH_SLICE, gen8_snapshot_mempool() uses first_slice when
> accessing REG_A8XX_CP_CHICKEN_DBG_PIPE, but then unconditionally programs
> GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0) and RMWs the per-slice registe=
r
> REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE on slice j =3D 0 before and after
> gen8_snapshot_indexed_registers().
>
> On A8xx GPUs with partial slice configurations where slice 0 is disabled =
in
> a6xx_gpu->slice_mask, won't touching REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE o=
n
> slice 0 during UNSLICE mempool dumps access a fused-off slice and cause a=
n
> AHB/NoC bus error?

This is a specific sequence given by the hw team.  But AFAIU the slice
configured in the aperture shouldn't matter for non-slice reg.

> [ ... ]
>
> > +struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
> > +{
>
> [ ... ]
>
> > +     /* If GX isn't on the rest of the data isn't going to be accessib=
le */
> > +     if (!a6xx_gmu_gx_is_on(adreno_gpu))
> > +             return &state->base;
>
> [Severity: High]
> As reported by Sashiko on v4 [3], should a8xx_gpu_state_get() call
> a8xx_gmu_gx_is_on(adreno_gpu) (or adreno_gpu->funcs->gx_is_on(adreno_gpu)=
)
> here instead of a6xx_gmu_gx_is_on(adreno_gpu)?
>
> In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_gx_is_on() reads
> REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS and checks A6xx bit definitions when
> adreno_is_a7xx() is false:
>
> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_gx_is_on() {
>         ...
>         val =3D gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);
>
>         if (adreno_is_a7xx(adreno_gpu))
>                 return !(val &
>                         (A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER=
_OFF |
>                         A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
>
>         return !(val &
>                 (A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
>                 A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
> }
>
> On A8xx hardware, GX power and clock status is checked via
> a8xx_gmu_gx_is_on(), which reads REG_A8XX_CX_MISC_GFX_PWR_CLK_STATUS on
> A850-family GPUs (where GMU MX may be off) or REG_A8XX_GMU_PWR_CLK_STATUS=
 on
> other A8xx GPUs. Calling a6xx_gmu_gx_is_on() on A8xx reads the wrong regi=
ster
> and bitmask, which can touch unpowered GMU MMIO on A850-family GPUs or fa=
lsely
> report GX as powered on and proceed with unclocked GX register reads.
>
> [ ... ]
>
> > +     /*
> > +      * Capture preempt records after cp_clusters, to make this easier
> > +      * to decode (ie. so we already know CP_CONTEXT_SWITCH_SMMU_INFO =
and
> > +      * CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR) when crashdec =
sees
> > +      * the logged GPU objs)
> > +      */
> > +     for (unsigned i =3D 0; i < gpu->nr_rings; i++) {
> > +             a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_bo[i],
> > +                                  a6xx_gpu->preempt_iova[i]);
> > +             a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_smmu_bo[i],
> > +                                  a6xx_gpu->preempt_smmu_iova[i]);
> > +     }
>
> [Severity: High]
> As reported by Sashiko on v4 [4], can this loop trigger a use-after-free =
on
> a6xx_gpu->preempt_bo[0] when preemption initialization fails and falls ba=
ck
> to a single ring?
>
> In drivers/gpu/drm/msm/adreno/a6xx_preempt.c, if a6xx_preempt_init() fail=
s
> after allocating ring 0's preempt_bo[0], it calls a6xx_preempt_fini(gpu) =
and
> sets gpu->nr_rings =3D 1:
>
> drivers/gpu/drm/msm/adreno/a6xx_preempt.c:a6xx_preempt_fini() {
>         for (i =3D 0; i < gpu->nr_rings; i++)
>                 msm_gem_kernel_put(a6xx_gpu->preempt_bo[i], gpu->vm);
> }
>
> Because a6xx_preempt_fini() frees a6xx_gpu->preempt_bo[0] without clearin=
g
> the pointer to NULL, and a8xx_gpu_state_get() iterates up to gpu->nr_ring=
s
> without checking gpu->nr_rings > 1, iteration i =3D 0 will pass the freed
> a6xx_gpu->preempt_bo[0] pointer to a8xx_snapshot_gpu_bo(). Should this lo=
op
> be guarded by gpu->nr_rings > 1 like the other preemption paths?
>
> [1] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qua=
lcomm.com
> [2] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qua=
lcomm.com
> [3] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qua=
lcomm.com
> [4] https://lore.kernel.org/r/20261030211928.45761-16-robin.clark@oss.qua=
lcomm.com
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102220405.30=
730-1-robin.clark@oss.qualcomm.com?part=3D11
