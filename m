Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D72AC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14A210E4BD;
	Mon, 27 Jul 2026 17:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9O2Ssum";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAsaMzjp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC4910E4BD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:42 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDleUH033159
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NnKGuinEzab
 GvkvID4K385i66E8Iq+o2wHXhRmPpykI=; b=J9O2SsumrkGXRlssgjjirkf6ba2
 InnICcd0wgO+aevOVI2lFPGRZj1AsVRgxFLF7mJGLW8E8WvZ49qNaPbd9K0mT62X
 D0OWbaaDfYjvMgBKev93xmDFT/+F5VYM7hZQdNVJmO0fskBZ+bFaNVf5PdOjngbP
 mgrFpWwqmoiXjxI/5asI/uO3U3M8orXagq5xcO60KP8BCqX20wDTSIcNwZHW9vWf
 R8cvi1mhg8ulSiBfqGNYi/K5l55j5Txm4bOopmGfecJw7IWvlxoiMIZu89pwjwrh
 yqWvE66wxWFP5cLCwBDLPnnMgMq4QjFZr+LNaDgp6uoRxWAGgfnWbUMUdaw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c6268c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so36273461cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173621; x=1785778421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NnKGuinEzabGvkvID4K385i66E8Iq+o2wHXhRmPpykI=;
 b=IAsaMzjpbx0q1S0t4qG45pBiXaxVpxtMrzyvCvjN/VlvtNGAawSPH4uSaE3JFxWCv6
 Uiw0B8DcW9dNFuPRX3y8JJYkOhxhiVCt9hqSSVNiCoENUCgO8nTgHWzmkt8ibcsmoqza
 cxaQE4A2LQUpSQltf8JeJ5PqevUf/jmdXDsEXaI1vVp/q49TaL2dwD/LjKsqjAcLvGb5
 2RXmJCJLbHpX+PzVy9AKOJAiFwG2bjn20uL6M1tRGGFV5gvHRHKqUQnERwO7B/WarkbW
 JuSR78d2FnlpwxrVBFQ2ntOpRu8iXc+zRrlfS2v/NAS8+jOEfizA7cWSgoPoJ5LHQXlO
 SzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173621; x=1785778421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NnKGuinEzabGvkvID4K385i66E8Iq+o2wHXhRmPpykI=;
 b=G7c7kVdd4tEIawQ6mw2xTpxW1/d5aks0FzFE6lZZW2o0Cnaoeps+jVbUpYBNSn+cq7
 wcj/DBxHRSMy9vP2KmwIHeubd+a58DmK0CFzM+j36KUHCUD7V4pvXDphnf3Ra4eZopS/
 uX7onA199BKO9qOcyV7tZC0nOiHEnz/f7PE+aAPnh5b3oXq6lljnLqtuM5v6A+SXvJtF
 2GZ0BsUYBtWDBqENXYb9oJSyloQbXc5JbrxaqlcP4UnvnBeHPs0fKR91FNfjr0Txt/WR
 xLNzVppRPG3bmluK9yfeI+gWqFBiJfpkbfMk1a26DFTPG4kOOvOOwhRgsVIPsqYir4zY
 3sPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeujI61NSF20heyFnLx01XCfnlk5AmSdOJd21zGy9AuUOm+cl0tFYVsxgeqFGie0y7pKfVJEMGs5s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyxe1VgNXPhtb7CfaYA3nFV0QPOm4oOFgXh+7UGWgQUTBnP+Q5C
 r97cWsrfonWH4TMFrDgprCxmb1prFhGjO9oOqoPrSonrfARMAO2McTlhdv8mN7NqJP3TeSaoCsv
 y0Q6hA3MU7XzUnU+n8kbDkSMUXouNlNKSrYbQf0t7PceogwveQ6jiRAfMtUCHUU85JMr6VSI=
X-Gm-Gg: AR+sD13pzgCUSEQ0Tnu6lAo/k3UwMAn79exGgKUUquI8lSFQwqipuuCqjdUJJr3B+Xg
 A5iCmX1nWLyrzsssPEcEmxJmlOjNOpdF7magjgbvGF7eaZhJJNViHMRwG9pXI9aSoPbwoHyiGFz
 HoNdjdNJ2bhEqEbYgbs6GPRUoKLeHr+hSblrll4QeS02XjUocvyRbqlXZBbdNJibYj7MRFa2Lz1
 bNEShnzBJgveOzug0ENhw/6nxJm1zF2Uy96wzrPWedmvpnIywJbnpc109GuMVxLhAgfjebeYmg8
 cArnbWPjYPOo6HKqECsmgc2rh19TZWg68ryYUv4OgAfrs1hZSkNq/s1T0eN4GomJj7SunEqM/N2
 Z8g/ybYaptti3NBJHbneX6Oe3mW8m62Viirk+fSMV
X-Received: by 2002:a05:622a:5a0a:b0:517:72e0:612 with SMTP id
 d75a77b69052e-529a864cb58mr95958231cf.42.1785173621308; 
 Mon, 27 Jul 2026 10:33:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5a0a:b0:517:72e0:612 with SMTP id
 d75a77b69052e-529a864cb58mr95957871cf.42.1785173620802; 
 Mon, 27 Jul 2026 10:33:40 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:40 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c
Date: Mon, 27 Jul 2026 19:33:26 +0200
Message-ID: <20260727173326.2219191-6-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a679676 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bDPGSfewVkDLoBZFfnUA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX7Lakt3WL5xbF
 tHtiqC9hRXPceFtS4PFRj1h97ixq915/w/A6UgoVzDljuWndgJLkhjuywWbGdHO1ECTKPfDXoVf
 iybZ1ZZFx8oVz35cHCWPjhmT48oF5/I=
X-Proofpoint-ORIG-GUID: dpAqKKyzqvXYKWktOG2dD2O_JHq8rxxl
X-Proofpoint-GUID: dpAqKKyzqvXYKWktOG2dD2O_JHq8rxxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX6ul539qidt2u
 rwZz75AzVGScMgT5FCqNtpwFnRz/h1u5OVLWiM4gXL/Z8+1qSbs7UPJs4xQgLX8J+5c1wptw9hm
 mWAlqjqLb16vCVBMQR0sU0JqlZIszGuQpd8P5gj9GSjspsIsPM7MaPah3TS23VmXDLJevSrQNn+
 wNG9e1DF9KjYd033qFUIcGGo6nfWOB4lC1DSzdRQTeqYueugO5bdUBeUzlXTsSGq264NbFJalRU
 G8E0nezhRXsmsNYqTQ+IQoOuMnQbSrlG9CFCvvCoWdVuIRJ+YcWD8Ps6I3IAu6SgDrictCKiIam
 Orov6i+DM31MLw6Yd50wmHCQo7XB77pdLj86v8VOeFNRJ+QLO0j4t88ueQQPox1X1/REYzzSs+L
 L93DohG1lrSetGveVjMQ5c3SDX7s5o4FZIGW2aODCabKrndz6Iw9E3HJCmzuqpvYGL4XUco5Ino
 s4KjspIR3TCrx1dLelg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270162
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

qaic_ssr.c uses mhi_device_id implicitly. Include <linux/device-id/mhi.h>.

Fixes: 9675093acea0 ("accel/qaic: Implement basic SSR handling")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_ssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_ssr.c b/drivers/accel/qaic/qaic_ssr.c
index a98928654959..418f14936f9a 100644
--- a/drivers/accel/qaic/qaic_ssr.c
+++ b/drivers/accel/qaic/qaic_ssr.c
@@ -8,6 +8,7 @@
 #include <drm/drm_managed.h>
 #include <linux/devcoredump.h>
 #include <linux/device.h>
+#include <linux/device-id/mhi.h>
 #include <linux/kernel.h>
 #include <linux/mhi.h>
 #include <linux/workqueue.h>
-- 
2.43.0

