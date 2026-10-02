Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139B1CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A56810F8E9;
	Fri,  2 Oct 2026 15:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSeE7o3j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K9c/Liqj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117CB10F8EA
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:29:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGjVS434944
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 un/LUUkjqWr6dHZmnZCw8yVwZVLyrN70wo3B1EMvQCA=; b=dSeE7o3j0Ls6N8KD
 /K1QyYiGFAHIGPBFUy2HW7ZOzK9yE+br3UrogTeQIsKt6ov93RxBzz68ppf5nebE
 uHuYdBYSqMH7a1v/6SIZmgSa7HWwhVwx04x7rhdQlNWXzXrEVODipZqjAULYZifJ
 xS+8T3VemGMo4pZaRwRvy5ZCC8BKEe31ALpNJKSrcEQugr0vItzzHXOILZH/78OT
 lvqFMWALuSp7IBuno8PaFR0O24yd/LSVXDJIJm2yWGZ3y/ydPvKQ5FwiweGF1fNK
 DyiUGUUyNA2Z7/jUJscdwK9hJDsEOkuQz7SOU3dyuCgWwPmL2TRA+PG2ZgeqQlDk
 moGFBg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxebrvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:29:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc7695f6a30so8161827a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954998; x=1791559798;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=un/LUUkjqWr6dHZmnZCw8yVwZVLyrN70wo3B1EMvQCA=;
 b=K9c/Liqj/y2Il3+DxKaUK3Resssu9vP7P15mj1lmRDqSvbYYlx8t0/bKImE2HS1DZZ
 tLqB0BZATSNvDurhVZPh5jSAOqvzRcBI9+P/kWvMNGQ8Gys425iUYhdCtyyv26x51XZe
 zK0WQxyFqPQZJAsyrtTM064ebPxLeIS+4FgVEqAL5cH/dMIZdxnZKcv58Tr/nZw7jkBK
 joTBQTPc41jQTPLo4lZHltO/r/QIZ/OpKxcYC9c0jUMJadVu+hqSpUBC0e+xZWe9xXVL
 ppLHQuwi+vwIHCD+a5uyMPKZJDng0H9rc08WvLimEDgdxfMEp6gJlDkRDc/VdPsfA3XS
 lbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954998; x=1791559798;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=un/LUUkjqWr6dHZmnZCw8yVwZVLyrN70wo3B1EMvQCA=;
 b=yDfmBcrGqnPH6RWfcpJeXHRi5h8pylfjLCo5690dRzoOkS7x239SzBViRj3GyaYSye
 ob+zpv2/snxunhebyyasOvwGAFdRlv7ynyQtkyOMQaBjdJ+hg8J4L+ptN4JqlFXb2QEG
 0DXFC8WySQn2B9ZWk8HPzeMvkMB/AcUX3xV8Gjx9biyqjQHII9u6tMhXHQpv04yTxSJZ
 7jMNi/n0AhC7Go9g8ZeQexNkOL0xnt2VSNJBhsv4wfSBv71oVdUcS4O0fyQyFB25UE23
 4LiFl3Gqd8d8ATvPu0eSratfatBTac1WDvyQeeit8fWHIEGt/T4nUFjqtCSkAQkup2K/
 /59Q==
X-Gm-Message-State: AFuF++lCzICpyI2loJEmt6cL2TiMz65ifIotH/CwjcnXqU2gOHHCTfDb
 IoHqUlh8vw90uPJgyPdwnXFixoMxSLl7sAHulwibFKrrRBQpk1ktpPH8/nFsg+4jtPEWJo7nBvL
 suGfYnt/ZtGkOR7RpczIIHgVAokKl8a5Cj4oc46H0yaPqCWSKi4WKbwi7Gy8kqmwOxaKpkDiigS
 gftWc=
X-Gm-Gg: AYBFou3WBVXFxH6mr0liBmB6bxM4WkuF8agnJ0rMiUHHeE/1aUjoP4Kv/5F2+azzGVK
 Ir78XwftU+PRAfVeI+UGy2TkSMI1kFrwW7xZbzPMbhzgnsFSi5mJ5kZ+6hsSZnUQymulChAKknA
 /fEh7QGBVU6qLy7hf1WlIeFaXro2mi2wF7ldL0mf7KXd6/F481iHWaXy+WBaBrqUkJ+qmKK26Y2
 /JeqoEk99RoohpElydggRmWy62elRcMMSNd6O7fImI5bs79c1judFAm6Rsc3V5s/zTA62//7hyw
 pehqZ2p8zAFh2Rt0UIJFiVP7/09VzkRZe347DgqWqsmbj6wY0TW213PRfQgVas4/c5NyYOk8ysL
 G3V2YB+i6Z1IsRmWQwGxPfkE0G2kBXfWnNBxwhqGIVenIJnE=
X-Received: by 2002:a05:6a20:5493:b0:3dd:a006:55a2 with SMTP id
 adf61e73a8af0-3e0bd01fbe0mr3757152637.48.1790954997681; 
 Fri, 02 Oct 2026 08:29:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:5493:b0:3dd:a006:55a2 with SMTP id
 adf61e73a8af0-3e0bd01fbe0mr3757115637.48.1790954997237; 
 Fri, 02 Oct 2026 08:29:57 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0bfc3da9sm1093702b3a.25.2026.10.02.08.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:56 -0700 (PDT)
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
Subject: [PATCH v2 3/6] drm/msm/gem: Use get_pages() directly in vmap path
Date: Fri,  2 Oct 2026 08:29:40 -0700
Message-ID: <20261002152948.85308-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abfcdf6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=bRy0bLnbznpkn9JxEt0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: CYLR_bNFVyXu2mYvT6lqhX66nz1T_5Kc
X-Proofpoint-ORIG-GUID: CYLR_bNFVyXu2mYvT6lqhX66nz1T_5Kc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX8tMYXvG0UMxt
 D3pdHrtV0+ANfsqJ0GvodnxxA0+rabhTiOGqeMZmjh8TeFSY99i4O1M0POf7TwQsBJyLTkVha+v
 YWLRoWw2g5gzlZYvZ+pxpy72SsLqBKSazPq7bwNhFsGHbaC+n8wcED5gQhXitMaLWIIi1DBD+d5
 I5OXDWO2Z4ukEH1cghujwjyMqCNxAEDHK3FjN5ew19TrEiGrfyBpakHzVWAlynb9EyYEeF0XmgG
 q01TBkv5wt6b9BFjAeTr3x7ogAhWvsYiIelzNwvcNiqT008e5n7NjhjqHA9mXir8d0Rm+UZyW3y
 waSp3/JH1OVrBMGGNig6zk2aoaN1OnEORbpoOLDirefkQgAH7IdE4+muxuo6l0xjZvIM5MbPWC5
 UsolBI6Ml4yVEHjybaK0sjCVlkEXHJ1vbufOv2XXcPzuLUC64XKX3WN4nYOodwzIUksPxoZ6l3S
 vG1kmo0gOwRuB4oDrpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX80t4sxAL/keF
 tXyObQA1OSVqLnr1Zj4rdkklDssi7G4lrv4INh1q9cnKmQsJO1mI6i0mSumhwYjO2OKDzkDaT/u
 WAQO4/2Xkf/qr9OIltAbg28kReHsTFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
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

Split out a helper to check madv state, and inline what remains of
msm_gem_get_pages_locked() in get_vaddr().  The vmap path is already
disallowed on imported dma-bufs.  And the rest of the callers of
msm_gem_get_pages_locked() don't actually care about the pages, they
just want to know that the obj is resident.

This gets us one step closer to not actually caring about the page
array for imported dma-bufs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c90336b3b231..bf6a8939af7c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -265,7 +265,7 @@ static void put_pages(struct drm_gem_object *obj)
 	}
 }
 
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+static int check_madv_locked(struct drm_gem_object *obj, unsigned madv)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
@@ -274,9 +274,17 @@ struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv
 	if (msm_obj->madv > madv) {
 		DRM_DEV_DEBUG_DRIVER(obj->dev->dev, "Invalid madv state: %u vs %u\n",
 				     msm_obj->madv, madv);
-		return ERR_PTR(-EBUSY);
+		return -EBUSY;
 	}
 
+	return 0;
+}
+
+struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+{
+	int err = check_madv_locked(obj, madv);
+	if (err)
+		return ERR_PTR(err);
 	return get_pages(obj);
 }
 
@@ -722,7 +730,11 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 	if (drm_gem_is_imported(obj))
 		return ERR_PTR(-ENODEV);
 
-	pages = msm_gem_get_pages_locked(obj, madv);
+	int err = check_madv_locked(obj, madv);
+	if (err)
+		return ERR_PTR(err);
+
+	pages = get_pages(obj);
 	if (IS_ERR(pages))
 		return ERR_CAST(pages);
 
-- 
2.55.0

