Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9161CDE009
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0644A10E252;
	Thu, 25 Jun 2026 19:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORUVndAI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WT+CkppS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A6610E251
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe6UT2801358
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H5SCzfZY+cZ
 y5PgYB+6BQtHFEsZ/Uoh4sUu9a8QqdLQ=; b=ORUVndAIKrxwQHEALCGh5hLrjda
 svk+CMaVOz4ZYK8DUZxd9Eko5S4zLilyBdfSonXN0N8ac4NG/k3kHIEvQlUVnjJO
 CdfIzq67amHAXXHBZMTWIh8SBTG91jjQ86gJVnebJIxUgTzqs2pZAKph83RnDlA5
 YX2ON/6nfLyrlwq8bimIgnHB78QfdxqCnCaPgaN85HBtBAk4VnFc98gL0w3G6JR8
 +T/6rKDxA7TD123MaVwhvG9d+TrpeWCUd7Zo/kfHj13vmTQ2MDsfXRXXiGhYDYAJ
 s4mKvQwKvRcsYUlEKVWMEOj8W0rG5X+fDNgh2w7ikYEHZ1OW6SPJC6iC12A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmkxjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88da04b719so100979a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782414948; x=1783019748;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5SCzfZY+cZy5PgYB+6BQtHFEsZ/Uoh4sUu9a8QqdLQ=;
 b=WT+CkppSmmMK/wtqmSlqS5n0SDqoMNtEqxXFfEIK6iRMfu9A3ov+qfZNSEx2PaOSkg
 GZu2QKhYreVI2F8pLwXPLa597b5NLaQwgMU7+U78jEnMDPnYfSbG1LfFoSsnbGGQWiXu
 UaTn5CEBaEryOHiHl21OJ65QLQxiOD3hqO7ewN8c1DTt0aW0hX3qmwRgPp8zuNUoLHlE
 Y7sNijk9/X+eFpPjw+fd2bqN2PzZNOQlS73ns+o4SezC1+Lve07q7uwNMriLJe7amAaq
 FupGRfe1Srm07+Vlp5fWgzlHkl7NDgE8V+C4KcM4M48V9+SiWcICJYlvkCml/r+2P8os
 v/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414948; x=1783019748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5SCzfZY+cZy5PgYB+6BQtHFEsZ/Uoh4sUu9a8QqdLQ=;
 b=q+US968YKmTbGu2HQ2C8aBXFLdZvxc+FUG3Fuqzv1Czf2pBSpJ0D9vEmo48yjryR3H
 QbO/b+b5uzkvHKH1T71BmZgQmQTBtVby68YPCykLgGQKWUFwDwW8B6EvSJ51LRFNvnSC
 QNV3eFGGQalQoQbzteSDcl8QUqLJnEafPD1/XsDmAUNMvj5+wIlKWiy2sEpHjSbqZWec
 SxG0xL1zZLTJ5tabB6wwXS5FBun+/xDgwHCgww6JoHZhfyKynLuNlRYhWyuiDybM+oW9
 IZa9QcVt8G0ZPt/apJQcO8A5LaFt9tzUVh5IexbyIIK2Hg7If1/JpvZNS9KQbVkM8Z8W
 6R4g==
X-Gm-Message-State: AOJu0Yz3tB/dpCjL/MvPcQKJ1H+MbmgB9kYSTM30lgTuYvx8B3K3wAEd
 8AS4BOK4DTl+Igh8+R/Axtc6xHY8HZaxDSex72w+Tqgz2LT/03M5LfjUwoGnEp46bE1ou2TEYAw
 OzmuItJE/lNy7dVgoMXTTXYWLvFxTPO1c5ubq29WvqEiBzk6giJQuupiP3GUJ10qKLkWrWEuN9N
 MliEk=
X-Gm-Gg: AfdE7cn/YxC82aApeRQ/1+1ZJNLrv9Om+tWgeZ3lq0r9IO0KBsG6uFPJ964NvZOxG5I
 CTP0zLR78rtX1vcWVq4PLh0G9HyTCnUcjmQb3VRS3kRtscJ6eJLc3GMX4dkQM7PjXvKO9ILirDB
 OgBCvFVOAaiKj8TErI6DWxSKdPRgOsoJPjdbDPXMAOQZ63Rgwsz+Q6FLEQ3sazF5i48vMVNQbsK
 Hz/7CrWw2ERmqZodI09G4ei/5cbFGrzpEInG2hGDkCkYl7UyXH5ZHBQAJitsWL1EEAoa9/Ruxer
 QHe2CL4XSwY5GRNMiHjFWiDXsDZjYqKvD+000o5ko0/cAsjwA//kkwwZNV8/m6n5E3bWh0Kc0W+
 YOpY9PhYwc7wlnTDlwdNAUncUEYhZfY8OcgENOZ0832pUqyCScVbVBI/eGw==
X-Received: by 2002:a05:6a00:1a8e:b0:845:363e:12d7 with SMTP id
 d2e1a72fcca58-845b3ac25b2mr4424214b3a.6.1782414947745; 
 Thu, 25 Jun 2026 12:15:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a8e:b0:845:363e:12d7 with SMTP id
 d2e1a72fcca58-845b3ac25b2mr4424184b3a.6.1782414947298; 
 Thu, 25 Jun 2026 12:15:47 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fcc773sm5423026b3a.11.2026.06.25.12.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:15:46 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm: Validate lazy VM in GEM_NEW
Date: Thu, 25 Jun 2026 12:15:35 -0700
Message-ID: <20260625191537.47965-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d7e64 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VGCgC6sU4evaG-_1UnEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX2tHnX9pvjrYr
 mkGUH2CMiS0j5tViIO+9reU4VcVzXppw8SJYl7Egp4O4HO3ym6OKGO2qtZZP0cphCjHN1vE9/ie
 Dk6lJ7vNyZvgQaRVKZSSLICzRJ65vo+t0K9mMTR2sy3aeU5NSKIHP0M00Ukv1guw43yFEb3tjyQ
 +V6IrtsR2CYDErIMyTNwxEukYKV+wGj2c0Q7IsePSeSCeaMDFQcD2BZ/fv2IhE0pfeNPf6ktqsk
 zGVMhpYYKemGT6QE1k+2DrJ52AgXdjhfLQKRVWLoFMbUTaFfbFhUXPFNsRMXmQiLEbnsDCF7Rc+
 QF+kUGRyey+fVtGa+m6XnGHhfhiCUvXL1oLCv4LS2VnsQWxI26j58xO5CXQX3hDf7HK2yiPI/Uq
 7rJOnIwaE1fylzQwC8Os2ylq4ni2Qnrv9pnHHBU3+mnh0XtPslBhWOszkVso0VMu/i+oE5bzB7q
 xkeRZmk3VenGk8fINsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX/5wKN3nKo+ug
 aWfDG0JmEsqtLE8quOYvmPp30tZvhBjfLPqy50mW9leJZEmA5SxMi5y5nhWfINxkzkQTECGNnJp
 J2GiKm4sSZ1Sa26JG7zpfO8YZAZTpUg=
X-Proofpoint-GUID: wEoE8WNtmLsE5WGliQSNz09RzA7Ya3yN
X-Proofpoint-ORIG-GUID: wEoE8WNtmLsE5WGliQSNz09RzA7Ya3yN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250165
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..733a094354e1 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1147,7 +1147,12 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 
 	if (flags & MSM_BO_NO_SHARE) {
 		struct msm_context *ctx = file->driver_priv;
-		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(ctx->vm);
+		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
+
+		if (!vm)
+			return UERR(EINVAL, dev, "not supported with shared VM");
+
+		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(vm);
 
 		drm_gem_object_get(r_obj);
 
-- 
2.54.0

