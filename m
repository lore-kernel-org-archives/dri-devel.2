Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFB8CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B575B10F8ED;
	Fri,  2 Oct 2026 15:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PfHYpj5x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gtDIojab";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADF410F8EA
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:30:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGoTS896048
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sxS6ymcMwZy2UdPPmtMKkF3MthxRKVgfdvqIkGpimqc=; b=PfHYpj5xtGXQeRNg
 GvBf0nFZD3cbJySKkPmMctNw2PXXMBNyZDKxuvzxxWM2ruzgidSsMd7Vn6PcFzIs
 GU2OU1s6D/a0YV809fUkQpGCUULf4K7+gmIj0Jz1/UHyg0+eJyLacMQYgtcxAcAg
 TNsvh5sELPcq8uk9ayYCHG06B3YcVjGRM0q3qnvHniqzdezgkkhiMXZoewFhiKeW
 TojB3jgTfmIOh9Ihj3A7OYnck3AvXclkWhd7mYU1k7jilLKQ7HIqXY3V+O4ZhOIo
 Kn4v0S7F9r+EBKcBm3Cic7QceiPLm0da0hDEbHcrjoZbZkxi1MhvwfNWrY9kfWfV
 Q1oaBg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v0343hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:30:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so1381499a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954999; x=1791559799;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sxS6ymcMwZy2UdPPmtMKkF3MthxRKVgfdvqIkGpimqc=;
 b=gtDIojabMrs37R09Xdb+8yzBgWh0L/jW92SqFUIAJam2RrLH7EUe3FuSELwJ5J4fvT
 rYPXzo+2MJu8Kg7qk8YS19QMCYkgvxICk6rdmiqrQ+oq6otnIjBFbTWw7TgUdYN/AwOc
 iVE9AitXH02IwNVw1KBLKUpHZ7cY0K6Icsl8cszfX30WY0p4EIsgOYA0m473pcT7O8lv
 pYIjc1jGYhXhkilDmOlT9w3uFPr1hvTyKeg8zfO3yQ3m5nrTwmpfJLd9cJcZEGFg/kNF
 0hze7LVqAMXzejAHIwNdbqc3s/Pn24eDRzQh2KKYC+GszLCBjS+beH33XMzx5n5ekmCy
 wE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954999; x=1791559799;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxS6ymcMwZy2UdPPmtMKkF3MthxRKVgfdvqIkGpimqc=;
 b=BvbZGkKeoS3S5WbrUu5Akx9H6Rm9H9PJ5PMlPBJKNXZoTFHQ4DVN5qQ3/Z+1oqoDvH
 EbrXU/dTgyzW0N0n+gRffe97f5oQ5CIgzgz575as2axIVZ+qzv//5cKsMSKw5lUMzWJk
 50yd7rI4gE/8wLX9CaXKW0xSSjee4642Q52HY+fxZA3njduUZdULaEDHCZ7PQZhTi6YH
 WBvRhn/ejVVh/Z5TRqiIlHJUdEIs25hnpyq2EWMBm23GYUR3gymcHOBnCSaOGLnvlcR8
 vA7RD9+/eob604uELi32JmSafMNqNiZ5r0yESgX2Nlw0mcrjUxLm0nndpTCMdFiKSMV0
 hcvA==
X-Gm-Message-State: AFuF++mrdRibra5NHPWDP0zI81tf1P4B/xf3gbc3bnIFE583xiUgv879
 TwrcLjXkdW6u7fnlaqONo/ncF4wGTWgncFEixvu/RuwiC3h25YjNpZDNTK1e2iWAb3tscRb4uoS
 IZU2HGiWEAPSrSQYYOUzanlMlYBzhrvsNuDpwkCSmuOChvu0NErdovxW7Otw/i0axOVKCpRLl6H
 mgtnc=
X-Gm-Gg: AYBFou36bs5YILdVjItT7vUOJA9ZGi6zFlaNgBlYZa00VmHw8KkNnQS39XsV8/2fY+3
 xvmZcaoPN1prjiJnqU7Mac3L9yZamRWT3XBpL+HosLqHO3Sv0gHzkhA5s33sNkRDbP6WBlwnkZ3
 nzxhc8HXvPj+1k8wXZLjaCwJjG1qo8WNaFOXD0u26SplrXRjW28OxL1Tiem3II2xW2zGMIXgrr0
 Bo0VYnFvSWu+qsOACs7dGqjndfxInCn9K29ooQa3wSotLy0gwkX1wEYor93uIAGFtDkr7niMJeT
 RSqE5tGvwk/mfZmhLbZchFti7azXjDOJTgu6/JLNTKqp3Qvek9l/etAjTnf7sBnF99xTIT8n9RI
 EnXeHD19/bPEyW+5meF9Ll1ZkNapcPrp9pC0GcJUPd0OIlw==
X-Received: by 2002:a05:6a21:e10a:b0:3d3:ad6e:9ce1 with SMTP id
 adf61e73a8af0-3e0bcfe91camr2445776637.15.1790954999472; 
 Fri, 02 Oct 2026 08:29:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:e10a:b0:3d3:ad6e:9ce1 with SMTP id
 adf61e73a8af0-3e0bcfe91camr2445744637.15.1790954999001; 
 Fri, 02 Oct 2026 08:29:59 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f737a231sm1186860a12.18.2026.10.02.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm/msm/gem: Stop exposing a page array
Date: Fri,  2 Oct 2026 08:29:41 -0700
Message-ID: <20261002152948.85308-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXxVEnxSaZL0tE
 M+IlUvEL+WS0FUZHjPRAkdAhOyzGZGtybQhy2Z/XjBC8eGxXk2F2YAy/zfAePvr28kztzV7A0FF
 fywA/HvW6JsFLsQhlH4XwidFDMTmBNM=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abfcdf8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=qy49VNyTqSxgYBYDrycA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: t9ELzAoHrcQb3loLHgkyAF4n4Ws_FJg4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX2pXlWvbWjkYI
 Zq0zq5JCDZD/K1DtlUxpbuEDl9ti/rbZM6qKh0Yse1U9Yog8MdkR5R1agWXCsNowEgDHJP7mf2u
 IVc4T/HjUIzAbbaog0aqJI33hZ3mgJwCYHd2uUsDh+3PGhV2Z5W91R0EII4D0MuPO64Amg23HWr
 I4mt7/LF1K24KiUEoTSnWlsEtu0CCq92XLFMMH31bAakp2ePkwe+dSU3uSgLQxdq3maApJJMv+w
 LuZA3J9DedKzGgPdJWALjuuouUQRcwtGWj1E3ifzIXQbrMzJ3Gj0/3pIprQYMMRKxOQq3mJ6nBg
 ZUF7hfENeC6dx9o3rqsRyO5XoT5T/QWiSxzeM6JvMxGCcHsXx4VoFSniogH1d7YHX+uDWgCu64i
 WH0ic3K/v2F7sjwAMhgoO1Pjadsdy+oyIw1LYISmU2fkjQv/hJxmmGUAWOZ8XjBAj8ODZV/ogEZ
 VYhtSFNa2rDNQPITkCA==
X-Proofpoint-ORIG-GUID: t9ELzAoHrcQb3loLHgkyAF4n4Ws_FJg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020061
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

The remaining callers of msm_gem_pin_pages_locked() and
msm_gem_get_pages_locked() don't actually care about pages, other
than as a conduit for returning an error.  So convert them to
just directly return an int instead.

And rename _get_pages_locked() to _make_resident_locked() to
better reflect it's purpose.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem.c       | 28 ++++++++++++++++------------
 drivers/gpu/drm/msm/msm_gem.h       |  4 ++--
 drivers/gpu/drm/msm/msm_gem_prime.c |  9 +--------
 drivers/gpu/drm/msm/msm_gem_vma.c   |  8 ++++----
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index bf6a8939af7c..2341f209adf5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -280,12 +280,16 @@ static int check_madv_locked(struct drm_gem_object *obj, unsigned madv)
 	return 0;
 }
 
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv)
 {
 	int err = check_madv_locked(obj, madv);
 	if (err)
-		return ERR_PTR(err);
-	return get_pages(obj);
+		return err;
+
+	struct page **pages = get_pages(obj);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+	return 0;
 }
 
 /*
@@ -310,17 +314,17 @@ static void pin_obj_locked(struct drm_gem_object *obj)
 	mutex_unlock(&dev->gem_lru_mutex);
 }
 
-struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
+int msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 {
-	struct page **p;
+	int ret;
 
 	msm_gem_assert_locked(obj);
 
-	p = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-	if (!IS_ERR(p))
+	ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+	if (!ret)
 		pin_obj_locked(obj);
 
-	return p;
+	return ret;
 }
 
 void msm_gem_unpin_pages_locked(struct drm_gem_object *obj)
@@ -487,14 +491,14 @@ int msm_gem_prot(struct drm_gem_object *obj)
 int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct drm_gpuva *vma)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct page **pages;
 	int prot = msm_gem_prot(obj);
+	int ret;
 
 	msm_gem_assert_locked(obj);
 
-	pages = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+	if (ret)
+		return ret;
 
 	return msm_gem_vma_map(vma, prot, msm_obj->sgt);
 }
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 73dafe080bfd..4f681100ecb0 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -279,8 +279,8 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj, struct drm_gpuvm *vm,
 			     uint64_t *iova);
 void msm_gem_unpin_iova(struct drm_gem_object *obj, struct drm_gpuvm *vm);
 void msm_gem_pin_obj_locked(struct drm_gem_object *obj);
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv);
-struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj);
+int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv);
+int msm_gem_pin_pages_locked(struct drm_gem_object *obj);
 void msm_gem_unpin_pages_locked(struct drm_gem_object *obj);
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index beb7f22fd694..e1e74e9b7e6a 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -109,20 +109,13 @@ struct dma_buf *msm_gem_prime_export(struct drm_gem_object *obj, int flags)
 
 int msm_gem_prime_pin(struct drm_gem_object *obj)
 {
-	struct page **pages;
-	int ret = 0;
-
 	if (drm_gem_is_imported(obj))
 		return 0;
 
 	if (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE)
 		return -EINVAL;
 
-	pages = msm_gem_pin_pages_locked(obj);
-	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
-
-	return ret;
+	return msm_gem_pin_pages_locked(obj);
 }
 
 void msm_gem_prime_unpin(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index c11d021581e0..311205c7f1ba 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1300,11 +1300,11 @@ vm_bind_job_pin_objects(struct msm_vm_bind_job *job)
 	 * trigger get_pages())
 	 */
 	job_foreach_bo (obj, job) {
-		struct page **pages;
+		int ret;
 
-		pages = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-		if (IS_ERR(pages))
-			return PTR_ERR(pages);
+		ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+		if (ret)
+			return ret;
 	}
 
 	struct drm_device *dev = job->vm->drm;
-- 
2.55.0

