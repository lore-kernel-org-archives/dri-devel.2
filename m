Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDED606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iS1S4Rd7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QZHxnL2K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACB810E419;
	Thu, 22 Oct 2026 12:59:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3507A1125D4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:59:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xpGW2574043
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=i3RrBZvafk7STshfEi/3/nHJ0vPIDyyjkQrU7+4cVYw=; b=iS
 1S4Rd701bwyU4eTACNij+pP3wVjPlQ0R5+icSy77zeHC84qAsQTtG1U8pry2bHZ/
 XWt/2cidffKKZrWVdifcNquWxa6HZwl3tQpCX3MWRXLi8cRbRmDidaeWEVChOWSr
 txaUojVK1GatN9k5JAf0ICAokaoupfiCpDDy710idEBGy39hTk+YrgxqgjLp8US6
 FBVs74bEFM4Dzb1rlxPQF/+BXS9FtkywDnuDnIUz1WAlzBvcpanJLvMvnVc8Jpd1
 PmxatxNWTp/VDwQkNmGoymiBxVSw0KhwYL1yUmrAqza3yp0Hzw/x92tp8AKpeoK5
 EpnzTFw1Dj6p9uAPg1Tw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93akgyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:59:29 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-45e83fd0663so1717309fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673969; cv=none;
 d=google.com; s=arc-20260327;
 b=QPmNLxV+NGQGL1vsdVb/h/l2f3rm9xpRlWtdjlCr28+ImVt1ByVeqzGtn7ghFFjCJV
 5GTfD2JbOpl/QI8e5tT9obCMUfDQ5xTQPZyNjwHTxyRB+Y526GCLmKu1kLDZjEJLZbsI
 2iynl6dbXQhoVnm6WqwqMoaIlfffUuHeB7OE4bhNJJztPY7/l3fYwk3Ul6X4UVcBdZS+
 lYAIK1DvEHag8gHAlXY54vO3jFxrKTlOv7bTQHW6ZdDzfVwBEXhas7RkQNgFlVKf5IQA
 ljxlK/vtZCbFts6nbmCOaqbeQb465TtAD9v3XKpJ52ZV/U0+O2742v747IDQb8k2xsV9
 ZdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=i3RrBZvafk7STshfEi/3/nHJ0vPIDyyjkQrU7+4cVYw=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=ePzFReVTQCBIIpV0AKLsehmNnPySyUF4782hg5MSMrGRpxkfSBpsjGpqWlU6Fh1lqM
 0QcG9VDf9dvAofB7QCTXUaIvQruNqnC1khCjpSuJQZPmgiDQUKSE03jsZAshLxxwSrxs
 1c5sFDaCHDDob/ggHSDM0FMhVJ53TJ+eNgKLyPC9zR117R0lbeSf30QQ0NiqAqi3gxns
 qvJmzYiiUiXrFvbharBmMLQNPxkDpccGOPVTjg+etRPi/eUaaTQhT1DzwR5Qzg+A6vHK
 vUkOnkRD/hPzSMJdb9Lg3qVEdOrNgazCxVQLvOl3X7c+snmG8Lx9iDhu/mgGQHvS5NKK
 4UJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792673969; x=1793278769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i3RrBZvafk7STshfEi/3/nHJ0vPIDyyjkQrU7+4cVYw=;
 b=QZHxnL2Kf22na6HeMdOu5fZuibrpxA3tGitCgORgkijWAMVS6ZS6sE5DLGblJ3DBge
 gf2uX0cvPcYcnStL8TbStgPJCGeagK1gcBwy++hAdfwmJQaYXE6HtyUeQAC5pZypWJRV
 dhe7rySwyzRg8vVhMZ1gqsA0ITpmrLL2gPbLRn6Bh76pKq+XoRpFX6iNzZYldluFI20Z
 rMyv4KqIcoz8vP4rbTtot39B+eg11Skd6UvywLkiPSZY83xxRZUlH8fq2zdEXmmaB45g
 TpD5lzDVycC8htIGcsBZb+ppXlUGLjNdfQO9NeZnY/vtVHdX91YRvDNaWYimMcQdIw/S
 rasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673969; x=1793278769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i3RrBZvafk7STshfEi/3/nHJ0vPIDyyjkQrU7+4cVYw=;
 b=wzXdN0YbGtMkP6SuFTqQTJ/nIEjDnGYZ6xVXl6Is1XPdvH0HtKT/Y1B8Wahy+FlAGo
 nVZ1ylcNOlB8GJQfWto1e0X9tVpvg1JOmQCIvVaasne/0qznuWLtb1c7+Qb3LTEA56Hj
 p4mDJjpfDI0z2KiWJ1ZTiJ6FOOZugnZsWSRvX8kgiw99I7QJNplwacQkUB6PujarjbtL
 mdLZse+6fCxKfZuW9UdMm81sD9Y3/oG1QYLY6uM1MLOvm9nxekvIA0a44JN0aO0+TCq/
 fh3NypUZ+QaIH51L/btLbH5Lm2vprXsMIBjLjy68RZ5iJCvPQKQJCklFkX53klEdf70u
 S9VA==
X-Gm-Message-State: AFq9FYL+ikC2xOYQTttIkGCrg/Vc81CDWoWJwewYdOufKIUdiTI9KVZx
 t2xDflPGzEOy51p/QSUWUbymcMjav/Fxwhl0KyjgrkrI3iEPMXtzZi8EaJr7a8c9hbxTrtpNGbs
 LvuQZLypFzmwGxJ2m/OOoIq8y9Ojc558dUdnhEdZztPmzoo7dKSsTytApcCxkYle/maMrBMQ1g4
 Z8z45IBJq/ut3cYay0RVKzN+sEYoUVkV/TRK2ncX1kZAfVOw==
X-Gm-Gg: AYBFou2crCOgHADxe8SD35hMtGridyFMReZx3XGSJgRBHzh8qAww2EIEmMryrs7MXPU
 mk2ljBZWVeeRTvbsIJB9Snz7idypI3VoInrNburJiDa8HQZjEQAtRSNNemj0t+YCLfgE5su50Oy
 C7FmspRAyo8VJo+/ftDhxNrjidLOrhYgL/Os994MreMuGAMObLrh3CKwqQKA==
X-Received: by 2002:a05:6871:eb0f:b0:494:7af4:9556 with SMTP id
 586e51a60fabf-4a7dbf46478mr3354772fac.6.1792673968734; 
 Thu, 22 Oct 2026 05:59:28 -0700 (PDT)
X-Received: by 2002:a05:6871:eb0f:b0:494:7af4:9556 with SMTP id
 586e51a60fabf-4a7dbf46478mr3354750fac.6.1792673968289; Thu, 22 Oct 2026
 05:59:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-14-robin.clark@oss.qualcomm.com>
 <1c8f4222-e7e3-4b10-8826-60de6dd89a61@oss.qualcomm.com>
In-Reply-To: <1c8f4222-e7e3-4b10-8826-60de6dd89a61@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 05:59:17 -0700
X-Gm-Features: AclHuK_j2peSj2EEy0C9v3scBb9GJLWZ-SVmnhb2kk1zdZCUSfdubcX9VfE4n8g
Message-ID: <CACSVV021btWwF5a_S0YKs21uF53TZd9uMwuk5M-RQOm9JNmtrQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] drm/msm/a8xx: Switch to generated protect regs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: X5inkR8BgyPbJfH7wYFEk9DHKsyMWGGv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MSBTYWx0ZWRfX2pzPo18MbmxS
 Dkw/gWkAJ6VQNgXjIJyAUGRDKFulY70XbdVdQQlJpPMAWR5T3VEdofitSnImc1Ickma8rg7Vl3T
 MObIK9EEXHft1elBe/5Mpt4jcM4Nslc=
X-Proofpoint-ORIG-GUID: X5inkR8BgyPbJfH7wYFEk9DHKsyMWGGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MSBTYWx0ZWRfXzwzBVSxqx9+U
 rTF29rL1vLzpmYQI9dRuWCgw7ZzfN/O4+C+cVHzWF9C4AygrfPIqZM3r7NjWpvbNr1aTXvpeUkO
 BrQLcs8ze6bTOIeMvyC0fqFpfJir4mx1F5TYtIZHTkvHslV1WiClg3b1vgyEcUEI6V7OW61rkQD
 y1fQmtEqWuT1OvnGmv8VGlwpawLPluhw7qm/3L2/VMkkd7y8TxiLEEPed+JlKWiM7YN5BQlnFiJ
 nqtaC4hSH26whpkFExC+Y4Eewr6l+/nSg4RvSpFxoz0gcDvGhOrpNta2XEDsMBQu+rDn5bhjRja
 PS2wdEfDuJvX1X2u1hgb3LpQlRPQX5tniemAuBIqgoB7mv1yAB5EGnF8ZaW1N1v9OPu8CeRuodm
 qQZDnx2mBgE71LcM3yBf9tYsn1InV42khZnC92DMAawCrdX38xSRQjrwIn4PFQCio0m6D0ibDR7
 6U9+eNmFwQDYSh+nJeg==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ada08b1 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pqyDHntStqP5vayZH24A:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220051
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 1:27=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/21/26 10:41 PM, Rob Clark wrote:
> > These also fix some perfcntr SEL regs which were mistakenly blocked
> > since we previously just copied the protect tables from downstream kgsl
> > (and only sometimes remembered to fix these).
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> LLM summary in case anyone is interested:
>
> - Almost nothing carries over unchanged. Only 22=E2=80=9334 entries per G=
PU match exactly, out of 47=E2=80=9364 in each table.
> - The generated tables use finer-grained ranges. For example, NORDWR 0x86=
00, 0x1ff becomes several smaller ranges (0x8600/0xf, 0x8700/0xf, 0x8740/0x=
bf, and so on).

Most of the change comes from exposing perfcntr SEL regs, which was a
bug that we hadn't noticed yet.  (Kgsl blocks these and requires ioctl
to configure counter... but upstream the kernel just reserves counters
and UMD configures them.. so we can use the same counter to measure
different things per subpass in vk)

That in turn required some optimizations, since otherwise we run out
of protect spans.  For example skipping a UMDRO range if it is only
protecting regs that are already RO at hw level.

> - Several ranges that were RDONLY before are now NORDWR, or the other way=
 round, and some change length. Some ranges appear only in the new tables, =
such as 0xd200/0x3ff and 0x20000=E2=80=930x27810 on maili.
> - The generated tables don't reproduce some old ranges exactly. 0xfc00/0x=
1fff and 0x3cc6/0x1fff, for example, are not in the new tables. I didn't ch=
eck whether the new tables still protect that address space.
> - count_max goes from 15 to 64 for x285, a840 and a850. The old 15 was al=
ready below the 47=E2=80=9357 entries those tables held. Patch 13 also adds=
 BUILD_BUG_ON checks for all six protect tables. Before, only a810 and a830=
 were checked, so the old mismatch went unnoticed.

yeah, 15 was a bug

> Also one robo-worry:
>
> Unexpected: on hawi, GRAS_PERFCTR_TSEFE_SEL at 0x8610 is still
> blocked, because the new NORDWR 0x8600, 0x10f entry covers it.

-ETOOFEWREGS but, since mesa isn't using these counters I had to skip
exposing them specifically on Hawi.  I have an idea to use
CP_PROTECT_PIPE to give us a few more ranges, but that would require
some more changes, so skipped for now

BR,
-R
