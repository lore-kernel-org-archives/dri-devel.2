Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4961FCA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7FA10F8F3;
	Fri,  2 Oct 2026 15:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8R59dN2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/zCnrTu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5465110F8EE
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:30:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGrIi435330
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NTICCgegx83CMaefd/EXj8tYtmfzsjfJOJdBMrgs7UA=; b=P8R59dN24VRLzKXT
 C1IN982brIZqOzMsrWlAQLa+E8n0vS0+ikZDzBYc/VarhRVAnxcXYasL3dWipcJ/
 NEBINX+4l1IjpUIc1oRsl8h/XFVFfYubHBjshOEw2Ot3pjYZoqKXC14nhNiL8ZYX
 ZQ9QnBUlcE92eg9rJhksv/iUgEV2RN2GbcKuQk/FAu7WBAbJRr/UmfIVeRBO81/z
 1XFhyti+nYvDdPyhihoR5wcpZ4AK2m2CaHN+Rw88BPCvrqL5OLgY6fxntQkwuNSb
 b4nj37zANQPImZbQY9NIdmicCcc5jPTGwO9y/VExqJwEf6rVzpCy+d+saGkRWmmz
 a0nvbg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxebrvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:30:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a0be20102fso7525057a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790955002; x=1791559802;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NTICCgegx83CMaefd/EXj8tYtmfzsjfJOJdBMrgs7UA=;
 b=W/zCnrTuEjq0HdNXlCcvG11eE6YC7UxqhsiDU5tto+DOVyDjMAzGnOwhoQyHmEnrWC
 f0SxtNBpXh+DXpgIPXIm22njd2CGLN82WsyVVnT4AlbC4C97ME2ndMd7/O9LjmuI/JnC
 nqrG47HC0xuCe4t5gnm03EqgP/qtsEves5yxiv1MSVm5cnrB5V+ZGSii/pN/nCQzV3P7
 Hm5v7eHMRnKBhfFUhzl/N2u+bdY5P772Q2jzKWDR+jK3pbXZrcyhBabV7UkV75omQ/4y
 N8L3GsB2w8HYqMZoklqBO6IbtVtL+0j4Rf7bk949X5JMhN0rU90MWBzItwQwRZB9Eecf
 02Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955002; x=1791559802;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTICCgegx83CMaefd/EXj8tYtmfzsjfJOJdBMrgs7UA=;
 b=x1Od2mPyBx970mEj9iXPjA2r+dM42hiMDJYZxWULYuFsRRBn/GTemQfElEr32XMAXZ
 hbY3v368cPz/Afec728u/xGpLBZsNoyTR0kyJEpmMelIq2DT3SpLp4zDLOnT8QLA/dPP
 +aF5aHeYFo4hbYXBnruesY8F43lF9DzaRf9EuQIb1MzG94dKJ0y2NZwW1rOrZO6TnGQl
 sqWnPy7dri0ipILxfq3nbjwQdLLZwApgcR2mOiUsG9kQULN07Wk0X2QR007RK3RGRpIO
 OpZpIfgCSQ2gpSdjRQklopdnKqHerf10gFPViE5Cb9r7eIRrW3lbktVPGhmTmuPS3KQX
 WdKA==
X-Gm-Message-State: AFq9FYJ2kdZhZe8M4AvvC6PmNkVp2iJlHhrYWmEK+E4MmveawccgSIkN
 g2VSJVDOMwO+UvNlIYwpMCxCKzjREGl9N+v+SHcZ6GkOcATaM9AditSrbijO55OcGo5tNkYgV/m
 8EXxjSjFGWhmbM4zr7Tmd2AZ6l4ZVa5ocuU2bqSp9TWQJnRY3oR9TuMDKBnP2eRA8R+bTcNhE15
 N6b8I=
X-Gm-Gg: AYBFou0v4nZS+zznBVTziSIhpTGiUyz6bonGZnmj5ca8p9N9CwIGkySEBNkyzhAlZqV
 r3AcIqIyZe9fg29so9WipaD/qyVHecgtKrgl2YAPE/0BGiMK+0JO5kk8s/dwnWAgdFviBUkOZaA
 QHHobRfeXBOmtOIBZ4a1RosCfUBXacVnQ5aCZbJbXMUgvMDcXV9D/Fxtywv0Z1tpO/xo8vp3aaV
 S6Iz9OyeMkt4neH+o2/CM5Aeaef9himWvc61w349+sj/u0T1Pd/BUdj1lUfn7dEuVRsRyqv+XbA
 izSOXJIiijCpsbdRUE4Z803AT5P5bffO3Eh0au2XQpkxP8e6c4gTVpTml8dJ2293dcZLtjqPKFd
 h4L/9LCkUcqAO2N1mhjqcBbYfbxmO4z6/s8uDiNa4y6+RO5g=
X-Received: by 2002:a17:90b:3844:b0:39e:6c69:f472 with SMTP id
 98e67ed59e1d1-3a6cec1c749mr3289854a91.49.1790955001803; 
 Fri, 02 Oct 2026 08:30:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3844:b0:39e:6c69:f472 with SMTP id
 98e67ed59e1d1-3a6cec1c749mr3289830a91.49.1790955001162; 
 Fri, 02 Oct 2026 08:30:01 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dcbdd97fsm1643414a91.0.2026.10.02.08.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:30:00 -0700 (PDT)
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
Subject: [PATCH v2 5/6] drm/msm/gem: Stop calling get_pages() for imported
 dma-bufs
Date: Fri,  2 Oct 2026 08:29:42 -0700
Message-ID: <20261002152948.85308-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abfcdfa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=n7WAr1GF7x8bO2YR65YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5XF6BbNLTFnGoxD4Z7Mbtjm-SKmGs2js
X-Proofpoint-ORIG-GUID: 5XF6BbNLTFnGoxD4Z7Mbtjm-SKmGs2js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXwRcrQdePlvOu
 dIocvgQFCbENBzTzNFSZrO1owo9y9UiJH4Nxmo9kp9xVJqlRErsoZaHD+E743MdlbqujHf/N5SO
 N+pdNhWVBD9dYlzEN4V4+Pe7VFRU7HPnou3vpHJbnwBA+Z/5tDjlsgA5nUOpTyxlfUYuQM2HV/i
 2DB0VpNSqmCcqLBoW1/uPITS+f8uFbB8DWPrIX3I1oQad65Nuy0dXjHz5wctYGoxKI0pgFkUYbm
 nJueaA0HnpM73dwA6ucww2xUUvVMKpsmsDjzjeGrP9gm4ypLZ9zkzAS3h1HR8Rh1zJ7+9WZGdNN
 E8HNGfh5uhOBrIsWu7yfUF5zZqyzfilUOcArMBgsGpNuYgAvKde2mNi1AuHp4ygK/uilNxlTOZP
 2rW+a6rmmvkGvdb7oixb+yHKf1M3VnPN/z37TrtXwm1KUhlHpf1P/DgBY6DpLSfStQx8/n5DYuY
 58v4/j5u8Ko3KIuUT9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXxBLI+7bdJNQi
 Lsa8bgy20dV/ttWxI0LMD2zkxV6SsWsOwyx09teZ6wAcWpeJt5jfr6SEx3oNiJlj8ESi0wpLSxg
 o5dx9tbKL9oPiSnwdsLYCho/DnBVaAk=
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

Use msm_obj->sgt rather than msm_obj->pages to determine that a obj is
resident.  The sgt is populated up-front for imported dma-bufs, so we
will never go down the get_pages() path for imported objects.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 6 ++++++
 drivers/gpu/drm/msm/msm_gem.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2341f209adf5..3111d7389572 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -193,6 +193,9 @@ static struct page **get_pages(struct drm_gem_object *obj)
 
 	msm_gem_assert_locked(obj);
 
+	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
+		return ERR_PTR(-EINVAL);
+
 	if (!msm_obj->pages) {
 		struct drm_device *dev = obj->dev;
 		struct page **p;
@@ -286,6 +289,9 @@ int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv)
 	if (err)
 		return err;
 
+	if (is_resident(to_msm_bo(obj)))
+		return 0;
+
 	struct page **pages = get_pages(obj);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 4f681100ecb0..e92c6723d352 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -422,7 +422,7 @@ static inline bool is_unevictable(struct msm_gem_object *msm_obj)
 /* Are backing pages/sgt allocated? */
 static inline bool is_resident(struct msm_gem_object *msm_obj)
 {
-	return !!msm_obj->pages;
+	return !!msm_obj->sgt;
 }
 
 void msm_gem_purge(struct drm_gem_object *obj);
-- 
2.55.0

