Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9584CC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A5310F16D;
	Fri, 18 Sep 2026 04:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="g42h1p8/";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE0D10F16D;
 Fri, 18 Sep 2026 04:27:17 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I4IpSV1111029; Fri, 18 Sep 2026 05:27:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=wSYRDUhUydbYwdiUUtGqE1p
 hgMUHv0FTmYqzeTJxOqg=; b=g42h1p8/6IXPxmSZd6bBuYbc6d9M+CwJWgw62TE
 s6LrxBeOVUvlJdCyrD4QpOgSQs4aANxLvzu0JHVjJUxGpo9rkE6MGrKQ1Ur5E6e3
 WNmhuWFt4c5fh1Q/COhbUpYnl+pLHuDHy8kVuWYy5peCoIwxgx5wr/nA9i5MH62F
 i3JRLUoHGSVdtHXXBg+d5pND+HFfNHMVWly3pB17LXTwN5I0EPBW/9vYmNj97bd8
 guJHx981slsulRp1Il3c8VQdfvuuZCV390wNUSrFN1KJNqy0nT+Rn9Pvur/3GGkJ
 O2KNQaj1yT6gyGhuqp9fqMt7sVPpFkQiA+Q1HzOaIKQvDAQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtun90t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:27:01 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 05:26:57 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 18 Sep 2026 09:56:34 +0530
Subject: [PATCH v2] drm/imagination: Add job type info to pvr_job_submit_fw
 trace event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-b4-submitjob_tracepoint-v2-1-d9b104de07b8@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAHm9rGoC/4WNWw7CIBBFt9LMtxigT/1yH6YxhQ7tmBQaQKJpu
 nexG/DznOSeu0FATxjgWmzgMVEgZzPIUwF6HuyEjMbMILlseCcuTFUsvNRC8enUI/pB4+rIRja
 WbWV4U5dVjZDXq0dD76N87zPPFKLzn+MoiZ/930yCCWY60SoppTLNcKNliqjP2i3Q7/v+BTrw9
 y2/AAAA
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=Y33ELKfAMzrkjFzF0kEnX1fBpNvqnSDzITTAf/KsW68=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrL2QEIO6+0mSLaSw8aD5j4X2aBiMlE1mwbMrq
 RTOwLbsYMSJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaqy9kAAKCRDQJndZfgLx
 cMLDD/4kgDjz1eCw/w3jyNXktdMwvbglIFYaLoBM29MHi35zb/CZxaOh0i5ru0Tuze3FvOGwy2S
 lcqGizzrUk5ajB8mjsAMC1iYt06QslyibRc86mohMNjRP9HHjMDdzH64y+vBcQq/EEc5HIYdvVO
 9Dcm1ccYeI8JxiDIgnb7ZpUp0eRlK+o1ILZlJoyiaSd2ndhWHbmPhXcB3JvPXekWhcIwcIoW9yV
 +090SA3G2LaHil0L/nXSaEMtdtkFOz0JmWvDVqSY1h/WbkZBkwf9V9FvwGPeoW6GjDaSrFcgUNL
 I7fDliKgukYTAPhWFPpEl+ElXoUsD8CETqP+ci2FgdJTW0EP9/U5MB+zMbwYO9/Nkl+WWRrumBd
 KOd7hcyHXeqOvKoJvCDrDOt7aHq1X3f93mHyJPG5YeIwIo6ohOCvniZ9GOaQ+Y+Vgq8RbBP5z1I
 pmMVz+6j31xk3h8Pg+8qKhu0H/gcxcmW6USMAmT4lVr1Ilja1hNvvSUOdMuu9QkkzIZ7p+ukT1R
 WqzwQwyY99XY7EBII/H9mF1W6fLzmD7nIipp0wo2OUFZZF8M0mzhdcOPWShvYvSICYbjQXH2jb2
 Okqnv8BRJ1EXQJh2/ZSj5zYrV05S1s1yd94wvKBa42jtU55xyM4N6u/pZ1eoxbzj3rEZMqGu0Cp
 aYjEhdaVil6SULw==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Originating-IP: [172.25.128.225]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aacbd95 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=gsgZ4iqZy9nM05cRbg0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: vtFybvpemEjxwsQ9jZrZlF0dmvW423Un
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA1NSBTYWx0ZWRfX8zg/9gU4m6vB
 mGyTD8ck6zmgj7gUqjrfVim8sDpxmug2Hc+I1BuAX1740dFx7m7r1mEGbmEXCJ8jpB7nwaXrBYm
 Uw/lpIgVEbABKxOZiE4B9b2f5uxTSS2kuj67t8WP9gAzWtEfKPXeje8F6iRPRtJOuSNhO1J8Rhw
 4hE7BfOyIij0xvTj05hIbn3uLGEzvaIxcmPat7VCZIGo1J5rI64cmInl9S82A6RGczymxLWLbiQ
 j+nkYjaBZf4u84QfY0m+LBJyuZu6UzwEvR0GEtRlK02CPJ/hoNXJy/RhQjRrsC9xxWD7RNr5eJh
 bITa+PsrrwsQ+Hrc0O/ncfKiPh0CBfaOqRhher1RCcT+2akpvQV+PNs9dQ1TtNZz6DzsNFUbBlQ
 nLqHqj0kWt9q5fhWQWpl8dIkpCqrDJ7QA6pUNi0BCEd4AblI2ka/3uzbmJ0Teq582sE4Z6YwTn4
 kTjjz4LrKN+J9NDpocQ==
X-Proofpoint-GUID: vtFybvpemEjxwsQ9jZrZlF0dmvW423Un
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA1NSBTYWx0ZWRfX7ia6wlGHtwX3
 ZVvr/pcMbbuJMpXYUvQPBsU1KT0OdSHkjsDTm1gWDiLz/6aK1unYkEW2h3VWmtsNwgUhs+KKq3g
 d3iBOf/WIrr9JDfWtF7eSYl+C6CVpOU=
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

Update trace event pvr_job_submit_fw to additionally capture and display
type of the submitted job to easily map events as per type.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
Changes in v2:
- Updated to latest drm-misc-next to resolve a conflict as pointed out by Alessio.
- Link to v1: https://lore.kernel.org/r/20260819-b4-submitjob_tracepoint-v1-1-f817b222bf6a@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_trace.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_trace.h b/drivers/gpu/drm/imagination/pvr_trace.h
index 943d6b2418cb..4be7d4b8a357 100644
--- a/drivers/gpu/drm/imagination/pvr_trace.h
+++ b/drivers/gpu/drm/imagination/pvr_trace.h
@@ -90,21 +90,25 @@ TRACE_EVENT(pvr_job_create,
 		      __entry->sync_op_count)
 );
 
-#undef PVR_JOB_TYPE_TO_STR
 #undef PVR_JOB_GET_HWRT_FW_ADDR
 
 TRACE_EVENT(pvr_job_submit_fw,
 	    TP_PROTO(struct pvr_job *job),
 	    TP_ARGS(job),
 	    TP_STRUCT__entry(__field(struct pvr_job *, job)
-			     __field(u32, done_seqno)),
+			     __field(u32, done_seqno)
+			     __field(enum drm_pvr_job_type, job_type)),
 	    TP_fast_assign(__entry->job = job;
-			   __entry->done_seqno = job->done_fence->seqno;),
-	    TP_printk("job=%p done_seqno=%u",
+			   __entry->done_seqno = job->done_fence->seqno;
+			   __entry->job_type = job->type;),
+	    TP_printk("job=%p done_seqno=%u job_type=%s",
 		      __entry->job,
-		      __entry->done_seqno)
+		      __entry->done_seqno,
+		      PVR_JOB_TYPE_TO_STR(__entry->job_type))
 );
 
+#undef PVR_JOB_TYPE_TO_STR
+
 TRACE_EVENT(pvr_job_done,
 	    TP_PROTO(struct pvr_job *job),
 	    TP_ARGS(job),

---
base-commit: a8fe4e162ba8212b7e51fdb024b37800f36b496c
change-id: 20260819-b4-submitjob_tracepoint-d374f065345e

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

