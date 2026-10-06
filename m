Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1220CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070F910E02C;
	Tue,  6 Oct 2026 13:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lq/MWvVz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XO0nCbFG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446DE10E039
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPRdE680965
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=73d5If+5wvWXlbXefuwdSQV/JC4Ap97CpwQ
 NGrCWZNU=; b=lq/MWvVzF3A5DX8BLdVbMjHtEHTUIQtbyk/5CdJdvjhfBZwihQd
 CsZjRT+n0UIo7tvrpeB6wuIx/qbyikzNfB+PT1lQJUo/givzcoySvbL+rPfICod4
 EtqeTAC5rT586btgbI6JparjJ5Yim82H2ObvNkhP7BmG3SXRlRlt/C9/3169sO/b
 iaQWK3x1iR0NZNfMfge/bjlu1Np0WqdYFbhnBi94i8F8awciHXhKKsEsEg3j2RzD
 NA36UNuMLT9db5l7wC2hxDe7E4obTpWX6UnHqPlk/hK1HcFPE0XeeVVHWRdxeueo
 GxNf7jgbFjiV+rZxK66Q9j2d4nJysIVZr6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9rpv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e5dcd82b26so5817625ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292208; x=1791897008;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=73d5If+5wvWXlbXefuwdSQV/JC4Ap97CpwQNGrCWZNU=;
 b=XO0nCbFGC5rSaUUykpoBs21oHRz80ULzQUsaP5pUmgLL+5yyxco+tyrBfsIcG/nDBX
 geWvi21ALoKwq0ctzX0gVI/mxTjoYr80L5kKVZwi69EcUtjWqC46lTO7B3+HQo+BnM2L
 zN1gH6SV86+TvsAqtgeqbWmMhiy+Q2us0SRwoBkdVn4Rv09s3nR3sQDhG4uOIzspZrbl
 QE0liX9QD2Z+w2aDn3DGHZF436zcy2drXzJvslfCfDkPwzEReZtEpPBk1DQ3ejay5Wvk
 Krc063gSaEkTWFSMcdcZCrgjwil/NtWrkYH5ex3wvYZWCIGRyxMS7AdcJ6uSzlQ5EBmg
 kLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292208; x=1791897008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=73d5If+5wvWXlbXefuwdSQV/JC4Ap97CpwQNGrCWZNU=;
 b=uJkfuVkXR4RVsMxJiB7Su8wStneqilvZjY4K6QGJtlTy9PACt/il/uJEZgCzbLNXke
 WfBNBRCAiNgWstuI9faRfLuOzwvWKXQGh6VxqV6pMKcbShZetIYT8kQ8VXeA5K+vSPZM
 q3u7e/QM+j93lW1NGVOlPL7asDPUXcuAVre4ErRxU6BBZSFsojGV0XIMMnC0I394c4YU
 XMGIRbQAXMci5oeAw0Cwjr0qpuaIBZqbaY54oRfWmetKsENRJoTqX9dUfVvgwpU8dU4T
 uXX88yPM7okwjC83RYqOwHrY6BDGkavTH5vRDfoV25ULx6WB1909HEGCn42V3Sr+1oH2
 EwDA==
X-Gm-Message-State: AFq9FYJvvkXoDofxJosSTZck8bGsniOVpTb0igKapQemleszUlQ+wTgI
 GiN+XH+BTCIMswKcq6E4L7sw2+64MTf+YbW+l3/7MjSZqmUIgGMbJXy/Ctx4K4NYmguaTzzBw0n
 3zLLiD6GW7UfPO6YmVfb8+iGzWcU0vcKim39eLryth/kaARDLVcOjyNpUOgCA7rlR/xxLYK89o0
 7umLM=
X-Gm-Gg: AYBFou2CaeGKito4byo8elCvWYJpnTTLuHtwxoWN3/Zzj22l/geUwZLSOa3QJjtb4qD
 qt3rM5r5Ap0XEu0/BnyjUBxmZHqZwZXOxMSx4N0cH3ZMzcm/1/MZ5569rsVR1mW4v2YW9VWP2s5
 jCGsqSQQ+LYvUqxOgJxlBCE35FD0hagPK4rFza7iiUox4eT+XdDmsXWFLtJGNax15Cwb1zuE/w5
 H5SYZLj8c8+5+J8Tlfplmslt/b2B+6cTuL4HoUujLmCp74KA1CNUP7uK293/iK3nclvB9XvbSQr
 M73iRoDflkrwY7YkvH/OwkLEgHYcQvF3Lytl6ZeTiULeuvcMJ2J5qf8VHqd/SGATm5gHEip5fL0
 umAC/AkUe9LUkEFXxV5dEiaJj98cZTGIbKaJuEJBaLFp5Bw==
X-Received: by 2002:a17:902:e743:b0:2e5:d2b8:3504 with SMTP id
 d9443c01a7336-2e5dcda0eadmr10857125ad.22.1791292208037; 
 Tue, 06 Oct 2026 06:10:08 -0700 (PDT)
X-Received: by 2002:a17:902:e743:b0:2e5:d2b8:3504 with SMTP id
 d9443c01a7336-2e5dcda0eadmr10856665ad.22.1791292207546; 
 Tue, 06 Oct 2026 06:10:07 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5e0634c44sm5960435ad.27.2026.10.06.06.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:06 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Andrei Kuchynski <akuchynski@chromium.org>,
 Benson Leung <bleung@chromium.org>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 linux-usb@vger.kernel.org (open list:USB TYPEC CLASS),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Pooja Katiyar <pooja.katiyar@intel.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>
Subject: [RFT 0/5] drm/msm: DMABUF_DEBUG fixes
Date: Tue,  6 Oct 2026 06:09:51 -0700
Message-ID: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4f331 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=puu_XB033Gd1UDA3wS8A:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX3LrPg2c+/G1N
 Q/lRGwpjpxuhwnnw0EDxKga9xIsezyKYbUhssKc6LwYutjoo8jD2/mgyzH0kl1hshcXlC6I9HpP
 E3hRR1GcP8tGhtNvqGL7YSV+DkRvq7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX8+w+SM2Pk/NN
 A/Tld5FMhEq2Bj5FgvKRuQ+WeJisQKw/kzEKJ9GEJDPF+eUE3DLgiWJkC0PrPy25ZFD2G/eUURB
 fUFWNtHEpuzyWaIQ82a7ETIO3hyW7rxU0StW+GKQiHltRVJuN4QZSmrC27H9P/mmNQO4ZjjdOuu
 OEGapqLeACcaHiLDOWkqo3Xoa+EyDLKRvAq0jQ0wdT2po8hAPofB0BJvAP8XkXI5ZyCH/Ecf223
 T0hhKcBZUOA3zpH6EnAPw6GDSVI7v/Gvm0mmefKstLRjvhQ8nnCQCQwoSRnk04CDnPVLRNZmqQb
 WsmJOp8dZ28dMOB3U0rAE7QwweTfVKrtYga0Wl8OkIzFbO9ljHlMld19raYV6txbu/XSYSKTcwK
 rSGHfzQ1AeMVxBBDfaceZaMo6rbkaOz6+zQ+wRlI9MPthxsSOS0rIduK3U14lyWgGjjWExgSVEd
 Gr83C5QTGOqL+THR3QQ==
X-Proofpoint-ORIG-GUID: IpGJCJaFjq7ygxqk36STwysf9Ny8nAoQ
X-Proofpoint-GUID: IpGJCJaFjq7ygxqk36STwysf9Ny8nAoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052
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

With DMABUF_DEBUG=y, the page information is stripped from the sgt that
we get for an externally allocated buffer that is dma-buf imported (as
opposed to an exported GEM buffer that is re-imported).  This is a bit
unfortunate, since we need that information for mapping the buffer in
both paths:

1. Userspace GPU pgtables (TTBR0), where we use io_pgtable directly.
   Fortunately this we can fix ourselves easily.

2. Iommu managed pgtables (scanout, kernel GPU buffers (TTBR1)).  In
   normal usage that iommu subsystem envisions the dma-mapping and
   iommu-mapping are combined.  We can't really work around this but
   we can stop trying to pretend to be a normal iommu user and just
   go directly to the iommu_domain_ops.

This all depends on being dma_map_direct() for the dma_map_sgtable()
to work.  This should be the case on modern things that use arm-smmu.
It's less clear when it comes to older pre-arm-smmu hw.  It's possible
that this series causes those things to catch fire.  If so, look to
commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to select
direct mapping") for inspiration.

Rob Clark (5):
  drm/msm: Cleanup if pages_to_sg() fails
  drm/msm/gem: dma_map/unmap_sgtable()
  drm/msm: Extract out map/unmap helpers
  drm/msm: Convert iommu map/unmap to helpers
  drm/msm: Convert map helper to use dma-address

 drivers/gpu/drm/msm/msm_gem.c   |  57 ++++++----
 drivers/gpu/drm/msm/msm_iommu.c | 182 ++++++++++++++++++++------------
 2 files changed, 153 insertions(+), 86 deletions(-)

-- 
2.55.0

