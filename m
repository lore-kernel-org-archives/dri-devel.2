Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB7606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cs9l87vu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+7hMxYN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BDD10F77F;
	Tue,  3 Nov 2026 18:48:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA34610E6AB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:47:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZ2pZ3318791
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 18:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DAZJuTvAB1Yu8kSVtfgthhDvd6V0vylumBn
 uvWXr9TI=; b=Cs9l87vuTkVvXKfErCXerHgC2IEiwf9KS52H5bytsUWb1nIYeiO
 8R5gWcf9aiG2Mups64cNpuDlIMYznsKj4X23Mexik38GsLJlZprq8BIrp+SKrAlN
 PvVeaw4dMGvv4EePRj2A9B647jR2lUJrkDvoUfGSggQ4VwoZorI4D64RcysvcOLd
 BMRZ738q2vRZWisPF4CCIAUyTfwGk8YKMPtiZA5tAOWHqE5wb8ssr1v3zVWx8gH0
 6Yjb1RMpwFpRhOjX58cr2sjV5GaXX1KUzwp/fCFjL6FEvs64NCjip1PL2SB7bdoP
 rwZ9VyLmdMo8H6Em6LKpTGCrJ2H4MWveSGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bhamv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:47:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso4759733a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793731650; x=1794336450;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DAZJuTvAB1Yu8kSVtfgthhDvd6V0vylumBnuvWXr9TI=;
 b=d+7hMxYNdsKpId+cGwdZGkl7K5mb1dW1mL3K6dwlgWLkoA57DudzIWwy7B3bQGOAUx
 xImwcP1eiw08WzBgWknxs3vkFhfiHPN/rzkTKQQaU0H7Jb0ZCNdo29xxvb0Tbm8EGtOd
 tL4c8sd0Oeukdvt1uW93SYc1EFqK9Y3KZR6lNrNF619QQqGZrorBsCl7lX+tsUi9A3cK
 Es75p9KqZxVDIrP5nrSnDTDFBx0u28IrM+Vgr2GGiREpN9HOIUAitdSL9TCBCmo3UKag
 Qpib0pkWiYw0PahBO8YNPQ3L8as92qSzTVHKzZQ2DrMgHtgrFPdUff9LVfVCHtLELF8B
 3Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731650; x=1794336450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DAZJuTvAB1Yu8kSVtfgthhDvd6V0vylumBnuvWXr9TI=;
 b=hcINhc8VNu3ZPSi5hoSCp++mFpTucxY0CHD8u2T/PZW0R4L7/Dtuy9ZT6wzThfaQ/C
 Z3EPA0PQViant8UhOhEr9MnbgYUiyPgz8MbG2LBDUXUqorpQ8viqDr8nPvd28p4fel1H
 YSN/VvlhR1mTQ2/D4+RuEoprJofG6kGRkYy0DqEgn0YHojQZE2by9uDN4iD2Lv8bYFlP
 iCkRBH9LkmxHjL1wh9AyANxy8Yu1FXEF4aHsw86Q744hofAZg5E3PQJ8h4Yr1tk7z9Bx
 XNEHRrtbyqz3p8ZLf/xKzNTTHuhlPJYFhNodE3AM9OY9h4Al2a4L69AEMiv9FxQG5d5G
 Pqkg==
X-Gm-Message-State: APuU4Z9vKkyEB1irjL316QELfvCEztSoLkjvkuams1rMTdBhSAWoKOvd
 7hl8I1BasSatheIwdTUjDg3ng+qcwOVVmfO4ksDzt+3C29eXUpXwNTxqlIKLFIGt0w1WvmCX9sx
 Zyf9AsFHsm4eCQPCjQ0ozpjs8MysoqzjC9kklrhf+ZB0NzY14GQnRynBIQm3k31cGTxV21O+LFf
 7GZvo=
X-Gm-Gg: AYBFou3xzXo9Y9N10xwlDyFv1mqqIAi3cGhqjbSdI6JIN8EmxJV6G+odp5wXBFdj+O/
 9xUcgJCUfROZ5jPDOhBsKEDemiXnEKc+99PtjcNVo5likDGEp2iFpecU6NF2exIxc6zWggj9ghE
 O6eqOdGdbNMIqm8IUz3+rR9ufSdNse9Tg04vZ8z+Yew1yDlneX+1rqDbylLI/fJnRHpNOcgRZKy
 ha2QTOPnpiczfSgJWqDvSkZqAzKgC6VrLwJOYMk47I7z694uuaaAcrFk5Al5H97wZF1+k5hZZld
 TP1s0vxUL/LsMToUX9uM9zZdLYc9egAjwsrhJRrxm77RFxREX95qfh6PVoBly+h7HEzsN5/hwcJ
 0xLvQbVG4gQoj7haS0HT/+3TRD/MXI5J6YQ3gnbgd0GxLZ824BZDheY8IaqbYvgsD4dRreL75+D
 8gf47bOkH/8PWwTk4q48bU30OYPU7UZ1uYF9tFVUQaG7DUfUAvwRr9iJPTTSY=
X-Received: by 2002:a17:90b:5868:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3ae8980a25bmr12072946a91.66.1793731650386; 
 Tue, 03 Nov 2026 10:47:30 -0800 (PST)
X-Received: by 2002:a17:90b:5868:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3ae8980a25bmr12072722a91.66.1793731643317; 
 Tue, 03 Nov 2026 10:47:23 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c2ab1cdsm5704537a91.0.2026.11.03.10.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:47:20 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 0/4] drm/msm: Decouple IFPC disable and sysprof
Date: Tue,  3 Nov 2026 10:47:06 -0800
Message-ID: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX3da2M+nQAP0X
 gS2FTS8Eaw+X0NaPxSIE/aH+CSy9wD8+XRWlm/mGd82z6tI4LJ4Vx9D0gJwJvAL8F6fPzfoYrGp
 0IfQCNPuV5T+p2vVXblQSJL8jMcrugI=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6aea2c43 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WAnUiRRfp7J0bigzDMEA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: jIu9HoKlNQ3sSFbmnn9Ls9iBHGHyOQ1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX7HktfPcibKTu
 zr1957HeQJ3m7MykgQF8tHEyOb2tpG0o++fl2JyyegLpnI48/+ocwC4VPYlOVAzfJmL47xc1NYp
 xak6fG//SLTJEEDUIQyYijo8WMtjLjNM5WU+57bmAadmL1rVCYSOWeHkRCvLqNDjlRlkC9ppOyi
 oTitl7HOafpj13PY3s7csqqBANRA6vbf03YQBJRgRitCEf11ggBNy3YU9CII/usQxjlsIdVotpA
 G8xgqSfgnQpaDqmhroO/eWOw7xrZfFjUwhoVf79zIRFRPzLA1xVv4MDDmFj9E1FikEuMg92eQ97
 KfiBNcdd5OoyvGi5dr2gxTt2auOOsWD+sMCt/n62nQ9RLSVlNdkT+REA81h4FMBW9I+tMtdTjro
 +ZXfv8Hy7A2mprHJjTRSgtSjTywuhk2DbxXHIfP9+yCJEB9zRTGT2Syv2WhgM8ZtwNyVOptCQ7F
 FfLKFJWDluCCuiiWy+g==
X-Proofpoint-GUID: jIu9HoKlNQ3sSFbmnn9Ls9iBHGHyOQ1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030074
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert IFPC-disable into it's own refcnt so that multiple threads can
request IFPC to be disabled without stomping on each other.

Extracted out of gen8 GPU state capture series[1], as other than fixing
a missing IFPC disable in debugfs state capture path, it is unrelated.

[1] https://patchwork.freedesktop.org/series/176505/

v3:
- Rework IFPC disable harder to play nicer with hw_init().  If we
  need_hw_init, simply update gmu->status mask and let hw_init()
  restore the OOB request in a sequence that won't anger the fw.
- Link to v2: https://lore.kernel.org/all/20261102190010.720443-1-robin.clark@oss.qualcomm.com/

v2:
- Fix double acquire of gmu->lock
- Fix missing a8xx hw_init() path
- Link to v1: https://lore.kernel.org/all/20261101174631.23637-1-robin.clark@oss.qualcomm.com/

Rob Clark (4):
  drm/msm: Rework IFPC disable
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 34 ++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 ++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  5 ++--
 drivers/gpu/drm/msm/msm_debugfs.c     | 31 ++++++++++--------------
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 30 +++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  7 +-----
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 ++++----
 9 files changed, 73 insertions(+), 58 deletions(-)

-- 
2.56.0

