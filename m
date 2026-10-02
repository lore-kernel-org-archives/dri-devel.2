Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E8BCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E733F10F8D4;
	Fri,  2 Oct 2026 15:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XyEBWpa4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ONXAaOLR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5B410F8D4
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:29:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGxcJ2751421
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bkw3YBDFOEu19kurF50MpC
 Nfo5r6r28dnJOjgI9UeiU=; b=XyEBWpa4Rrb8sWpYcBXfcz8Y1Lbyv46i9ha8nI
 j54XONTTvjuVyDH0/0+lUmF79hN13PhjHzu9f++0YmBMOZEk9Z/a7v+n2i5DDaJh
 N0UZ3QXKnH1dvJWctZ0x2qesfTuiELtTg7R9X6J1O3XPAEyfO05ckYvEQYaCEvBz
 XHHK/iFcTD1NlD0EtVpwD9Cg1SGPMxL0OPjffJC9wy2GMKvKOCy3avQOqD+4wONa
 tPA2/8od2jprdWteECQCjHbilJR18tKtGzX4n7zjfm1+u0UBLHS6WbpbjyMDOrqn
 kH6evzH9QE//7cO1aO9h/hqXJJiffHHVWC8YZF4zHKCPW0lg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mt538-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:29:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso51989015ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954993; x=1791559793;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bkw3YBDFOEu19kurF50MpCNfo5r6r28dnJOjgI9UeiU=;
 b=ONXAaOLRIbrRt2O4t0NZMe5ZZ/SP2eTG8qs4MilOA0V2Q+e+RXuyumj0TJvIKYUCEn
 N8nYQvkeyDjFd9kifSNusHrxrghSfsuOx1cuuYSgNrcmpOR0IB/gxtlBTtSPpdaEpzAV
 s4CFlkW2AxQJD5cReugB71+Ct4QcuqpEfay4+oDpzVFq9VAu8cymffpJtBWdSZX+p84l
 cTynQwrHzkNeMCE3xUmqemDaepl0HpyxU0RHMLdiU/8D/I5XxgYE6DekriWOt356aDCy
 K3XDAyN6CRP9StWt7mIMfkyyqRQ/4KOGoO7lzudowD0hX2BiaRbGFdCcOjYUlyV4d67h
 /rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954993; x=1791559793;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bkw3YBDFOEu19kurF50MpCNfo5r6r28dnJOjgI9UeiU=;
 b=xIEiYXCoWbJKusBNp5vvbZFxJBnUhqNQeytws0xeOTLj6Jbe85cbvO96F+wsnL2YIo
 GQ4vK+jw48RHGXmiLu9AQ7ZX3Rd6ukHscpGbTh6oq2pvGoFrgmJI3gZc5A7cFHR2zQMZ
 0XctzFu6uRxkCn8OUsn/emDulFAMU4GEGiRqN0SK7X6JeAr0nSkvuGAEznXHj+FFTwEj
 hLBNMGHannrj3jzOO845CBge49DZQFn3ueTw/3w1ZjegK9PmXVxr9u9/AY6pJFxZXCQi
 f17CSGgGB+j3SVqF1uh8IyOwMY9FCXw36uorpi1zmXWQ65oGRfMEPZCDxaBCLz9p/Ttt
 y4yg==
X-Gm-Message-State: AFuF++kLQ0NqP/HwOHGHyncOedusFp3dHOZwskzKGJN39HVxqUJTBTiP
 NCZE/qHQPU2mbOLWxfquaigAzrJ/0l1EjyXth2SaKLsRmb1it/IjqHEwy5wctYP7QI2GeOcf6qv
 0x9iVRtapH3wFGF/5VN2i3w0QdfwDBpmyo9iikmCzX7N+FrTWLOOau2Fjsnlkh1igjTZjcv0QYi
 XT/QI=
X-Gm-Gg: AYBFou0x44zXuJM+fXK5LtU2zPq6ySjRAIebG44xARzrm2owe36INMDEMziCQsfgvaO
 S1IC8sFPHP+WA5YOS7BWgjI65wK/eglYueiSSFJBmibZ3jJ0LefamTHOzqZhBprD/lWngN14e7r
 Vb7cHu+U7Fn1mCxEzWf08jU9y5Oj0OdeEg2X0IQdZF9tHADNPlUuMLnlNX6mRASPmdUTl6L0DcO
 6im9qiuexxFUY5hSqbqTKsD0Lyu4gwCovJD/NiFPXrWdxkwXxhS1PJ8q3ijHmzFwy+BK5h9pK3z
 dFV/BnSJl9FGFykIhsK0iGehomG2BBjRRCL85tllNc9LTHWBn/BiqKm59ByGEsFpNLCO2gIPq/J
 ro5aNez8ZNB+Y+RK1t+l23t44+h/ZNyb8v9uRv0IDIvLacYU=
X-Received: by 2002:a17:902:cec4:b0:2dd:c100:b2cc with SMTP id
 d9443c01a7336-2e49b807643mr24166925ad.55.1790954992680; 
 Fri, 02 Oct 2026 08:29:52 -0700 (PDT)
X-Received: by 2002:a17:902:cec4:b0:2dd:c100:b2cc with SMTP id
 d9443c01a7336-2e49b807643mr24166545ad.55.1790954992174; 
 Fri, 02 Oct 2026 08:29:52 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6ac12esm9644065ad.41.2026.10.02.08.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:51 -0700 (PDT)
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
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-usb@vger.kernel.org (open list:USB TYPEC CLASS),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Pooja Katiyar <pooja.katiyar@intel.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 0/6] drm/msm/gem: Drop use of pages for imported dma-bufs
Date: Fri,  2 Oct 2026 08:29:37 -0700
Message-ID: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX0b3bNeoiJ5hk
 AYHlKdPRPXDQHDuFC0yhwGvVSdyRjtVHWpg9g3/FpveqWXSukehYqV2DAsqZP6Z5xc6IUZjljvb
 TRSS78mi5A8KtHyIhTxq6pPln3t28cI=
X-Proofpoint-ORIG-GUID: B4t8Nya_4tUIKCotXL-WS_7V-17CKyuJ
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfcdf1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tIciJ6vaqEqC_qAMQbIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: B4t8Nya_4tUIKCotXL-WS_7V-17CKyuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXxHTzFHiK/IiG
 7fKWMPqOWe66CDNxGc49wxSQfwM1xtCzZV2OWMCTI3e2pm9cQfr+Um9Pyi71YyghC6L8wYz2Gdr
 XHHMB/KY0JfnFb2e2fH3nofBX7OAc7jpfskyOHZytB8pav21oWnv9hjcW6MvdhtjgzAZCjN8rCV
 Ftbgwuhe+tGjlh6WxugCy36gXn3YXMc4uVDe6B1WhynBmdLfJKBKoY6ZEe9bQ62+OjerjICQ4Xc
 4vSdZTtY0FRqWyxtnWYV8qZqHYxFeDBoOYbVCJNzpfl3D9VYj2uKFWFmmyIeynMfa6nFtCX6MtJ
 c0Ztqp2JLMteValD6UWzxpNNUGlD/RIsh/ERa9Ecs0BzLaeuhk89pOAXSCuPK2FkAIuFBg3v2ca
 ueTe/XGSuR29pTaJvlu0YYjWvkYf3A3TPfVxKqHNyMEQAm/xMu0FkBaIyxknBwlc/X6pZkowioI
 1xFa9khesdQ9olQicSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

The use of msm_obj->pages _mostly_ served to mark that the obj is
resident in memory.  Mapping to the GPU, etc, all works in terms of
the sgt.

The exception was the fault path.  Resolve this by using dma_buf_mmap()
for mmap'ing imported buffers, like we are supposed to.  With that and
a bit more cleanup we can drop the use of drm_prime_sg_to_page_array().

This doesn't solve the issues with DMABUF_DEBUG, mapping to the GPU,
either via iommu_map_sgtable() (display, and TTBR1 for GPU, aka the
kernel managed mappings), or msm_iommu_pagetable_map() (userspace
managed mappings), still requires pages under the hood.  That will
be harder to solve.  But this is a step along the way.

Changes in v2:
- Drop dead code spotted by sashiko in 4/6
- Collect tags
- Link to v1: https://lore.kernel.org/all/20260926183051.25754-1-robin.clark@oss.qualcomm.com/

Rob Clark (6):
  drm/msm/gem: Add helper to check if resident
  drm/msm/gem: Mmap imported dma-bufs via the exporter
  drm/msm/gem: Use get_pages() directly in vmap path
  drm/msm/gem: Stop exposing a page array
  drm/msm/gem: Stop calling get_pages() for imported dma-bufs
  drm/msm/gem: Drop use of drm_prime_sg_to_page_array()

 drivers/gpu/drm/msm/msm_gem.c       | 107 +++++++++++++++++-----------
 drivers/gpu/drm/msm/msm_gem.h       |  10 ++-
 drivers/gpu/drm/msm/msm_gem_prime.c |   9 +--
 drivers/gpu/drm/msm/msm_gem_vma.c   |   8 +--
 4 files changed, 78 insertions(+), 56 deletions(-)

-- 
2.55.0

