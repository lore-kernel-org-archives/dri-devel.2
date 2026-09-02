Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEEC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E204510E658;
	Wed,  2 Sep 2026 19:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDqjlIYf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R6KbL1aT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DC310E658
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:40:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HqtsO1650594
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 19:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=HcBBgWhUa/fey2yq1Yy4HHcqCYRd29uAL6v
 U55hKPm8=; b=SDqjlIYfsZepEy/U2IDe3PsHymz1seGb/9lY7sGIdRXHOfQS1XS
 dOAnPRWPBv6e/A1556MBtCDxnV/9FJckPuLHYsYfzyggFJMyufYjevXR7LsV9GkB
 x1wJulBrYUBxiE+SZZGAk1HgCAs2SCeu39WWme9thm3uaV1GPxT4iieF8L++xhV0
 SMg0geq8s08ck1HocycDfLa6MiK0aS90I1NzEQT2jefV1MBFvYAvIo7KOSFHFyY9
 dCHRrFiRg9qgLdtgT+9kY5yDEV9apgljUZ/RFP9ydc+oTDNQxibSeMDHxmzYFuSY
 LiV3Z9+hw0UPkLR2txlr8otQdbNpxev0g6w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4sms3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 19:40:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso1742584a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788378049; x=1788982849;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HcBBgWhUa/fey2yq1Yy4HHcqCYRd29uAL6vU55hKPm8=;
 b=R6KbL1aTIRZdAAsJsp2lNjjmYjtC1ZVCZk6iEmzm2t2NzNC84l0jmDdZAZB5oCKg0G
 JEbLBr1ODxGqSgV2/HzaT7xZVG/0qqte8cmMRnKJPYOKtIcMvRmbcjBElmMFT0ozYz1F
 hBk0Z+E0QVQGmiHiv42wfVYHc8I0bHsWVruNtevYaJzJDDav/TihZ4WlsjeQKE6+Ok0Q
 H3TNS9Az+fszsVNBv9Jl+Lqwu6wX+xY4ZI9I53y5ogb6f45Zddx2Ul3xXZy62buLFIf0
 48Qf1SzVZ5wzYDbCbpt1C93vnwYu8GxIK/eJdAV8SwFQ/MQsg0UtRRGSirZC+Zn699Iq
 pP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378049; x=1788982849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HcBBgWhUa/fey2yq1Yy4HHcqCYRd29uAL6vU55hKPm8=;
 b=YTd/V9rzhQ+6fRMb3Keko+41zQZzeRQtgFVwNWs3UuBQC2euwZ79GG/HWlH6fzzjAv
 DviGeNJXYgF8rGIZ2jh0MXUPgdlTMlTWqNew8MEFt7lz1rBtz/T4YisNvKWqaf4W2MlV
 BkXE45H5snGEgFr7Vh6uKOZvmdiyII1AHlYrFpTEACmFTpFDaSunYbQzwrjZcbb6ZCs5
 RQ4GN4C4PJkUZB5Q6p5oaJW5LJPFvF6Zl5+BGL+g2WhrmCRCHRqhnwD5tNzdRzAgDqN8
 diGzSfLMNf4euVsgz/tTLXpQpcKGRlUvLIuAqCUkADGU9t28twdgSqUaSzcbnVZr23kT
 O4ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqL9TGfXeGoIiCS6j10INj/Hzu49fYkk9MYnVvG2SunuOEEnh7qYhOpg1vFIxrlA5NyQiHnCa1atY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWXIb+yWajaJoaeFNXz95Ys0sQGLvdKnWhlmoGJdKZPxeQ1ET+
 kLeUG3Zc9usNTdo93PEbLOTgbUSFeYF97E2DKbMTy2Tnfa2VmH7pHg1DnX9UenhBPxS2t7+fQk6
 i+YcFUrH2cnverqOr9Mw3zvn7r6ie4boPYAkdZhTH8eyD1bBuvH66LSVpKYk6GTT/q9dvGEE=
X-Gm-Gg: AYBFou0rZoLLrddpK/kRdfx+eDjiXirVmIRoFX+sRygLBSyxV+yKj6c/XiAeDkrptHa
 gw3pJ58VuAXDpeohrZD5kbjo2RK46yuB90SCUkXXSbjIiqWTlZiyz61pBKLgTixPVXFX9b/HVro
 e2tOxuX1qZCrw0cRr0mNjvaPbeHDZHEGCbpVTtHNLEkMVTkFkxUexBpT4fwU0yTkGz9eci5fTV4
 nO7Gay9rbODBb8nXo7Gi565wCV1cVdw+prLhUfzj7emS2d/vBWKwBd9/i2KezGpxQixH8wD5uZq
 SY5JX4VGY1fFObR5y8tlCnHSRdKVs9RUXHp7JATFy9GtZ1QlNyLsC3YLHaGc/lvIehflXjTvttC
 /MvECu8XLWPEj2GUYVZeoDYYN/+4=
X-Received: by 2002:a17:90b:1a8a:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-39aee0e5de8mr10045285a91.14.1788378048657; 
 Wed, 02 Sep 2026 12:40:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8a:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-39aee0e5de8mr10045240a91.14.1788378048115; 
 Wed, 02 Sep 2026 12:40:48 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14319875cc0sm304877c88.1.2026.09.02.12.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 12:40:47 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2] misc: fastrpc: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:10:41 +0530
Message-ID: <20260902194041.1999834-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3MyBTYWx0ZWRfXyBx9r20VELjW
 VecCtFe6UM9flZtBknapc1Tuvc/mvlqUFdYK9Or6WNkzVkQNVZVGdh8TodMHYVCrpG0BDQWG0St
 tpzMG0k8c+SolFP6s6ZDY51oHMeeF0keXJJVogve0ou2aUpLuoxODhPEosmkekApgedPaGAbb2m
 LGdHSM6ulWOAV9d593oWWAxvaPo0qBPkCiz7UqFHM+xlb8j7oo2MT5MBgU7bnVUZ99brM1BINn2
 7QeQvMHH0MIlIQW7a59x9ysgnvQ3ymLKV/plueqQJUQMF5s1NSLW54AxLK3lftbQiH/Q1UtKK/V
 vo2kvaQMIMMroxiF3na+NHhneoSfxA5aeBVRYJkydtFxwkQk02o6sH4o9k9sFvrOf+yNgeVnPZV
 vtJ0iMhzaUz/60oRizizXSELYucg7EISo0x50OK95jP9rJSJxxu4AhfoLAM3xVzd9S9IT3Grcy7
 n8x1eEZBUmqusejcNrw==
X-Proofpoint-ORIG-GUID: Ump7YceLPD3o2NDP84T_V8-GAfygIHLx
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a987bc1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=12ZugxYpoLeGVrRS1ywA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Ump7YceLPD3o2NDP84T_V8-GAfygIHLx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3MyBTYWx0ZWRfX0x/jYq+EhSau
 UpVoDhgU4D8AWfQRL5+IbFIjvQbfLJ5YmIhfSov65eodhPg3ULjSb9xfsrzSRUsmdMIUv7IjMn+
 LkD6vJzWKS7H6ZACXMJEUCa/jecTKfc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020173
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2: https://lore.kernel.org/lkml/20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com/
 - Carried Reviewed-by tag.
 - rebased it.

 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..ad248e12fe97 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2558,7 +2558,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
-	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+	if (devm_of_reserved_mem_device_init(rdev))
 		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
 
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
-- 
2.55.0

