Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561A7C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A9510E44D;
	Sat, 27 Jun 2026 20:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+Jv4JnR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cjZsunRv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177C410E44D
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:41:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RJ0GGd1857719
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufB
 wKJu9ttI=; b=m+Jv4JnRf+MKiRVTSdnXpd9FU+6fzoyabWhQnEiqhcqrRpikG53
 9u2vvxJISXegRhJN991rrCfvAWO64+C5fBxbkVT1kX4d0D/JzsIwW9qJZRgaF/4f
 +Nn2L74TfbKWT16fJW/eOUQCJnG+EMMm9JZdaMKe5E+4XmDkG8SO9kAaSlOyX5rq
 5VmS+NLt8SR6YNA0k6rLQ0KxwCBsokfhyHlqwgEjuKt7KZ+XMINCMqkDxBBg0w3R
 Bzzz6SDziR1n7Fcx3LwVa7T/S97f44mp5s33rynUSc/JiNscXFwn5aLWnEh0Kqj0
 6Q3w7PkweVEP9S8spNm+k3x3el7+Z8M3vcw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf1jb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:41:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30e85f5bc9eso1765645eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782592890; x=1783197690;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufBwKJu9ttI=;
 b=cjZsunRv38J4EJdR+srmql8eFy6qkgtdb5x61kfNHXSNIYLegfRqKiKxArGMIDLinS
 ZcHu+ZPiknwpyOoS5WC3l39Y5JtBI6NfZeSUlCxwONA0yec9be4W+GuShbAX66PXIwEE
 OVQVwYBlctX2NacyY/HuDnm+Vk6PSc3JsMBi2uKclapMxv+AnSpSSQT3ciqTeoYPdX9b
 M7pUKuJe0NwgpAp76XIU1yQv+bzmudsFflPcHVKK3wv1K5HHedZRvEapEncxusujeM2y
 P+bIwW2qS6eCMnX4IWpc13mflGsrYYPMxLi6U0lHJRlD0/+NJ4tJ3txNK0zjYL9HJ4EJ
 ThXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782592890; x=1783197690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufBwKJu9ttI=;
 b=mxJnYem8HuXlP62tw2oA5QIo3FNe3VtMDS4nekPg/yOMei91Y+fEMJa8so+/qqu5wR
 x+41YZ2kvjdicxgeWEv8jn/gt9ilLpRztEJMXtkwNJgOCK49AJwIIuvbkuV/uCFa7vd/
 YEaRykhsETjrb+KhE8yVhjhNL4tWAhq2D8qwbHga6aNFsRR21BU2CskyAlX4R3kgJ8Wu
 JIlw3F/11oonevcaea9GhmJ4SSm4YqEpGhSLESqMGNe33khoNZD6HrqCUmZrik1bRuSc
 8wGu39CMYrfUyAWzUsWaYjXiUY6ddqcnb0/vtqpzIK+0YxyaYxdGHSqpHTQuqmDv3+ix
 SyFA==
X-Gm-Message-State: AOJu0YxlOj5Dlr9CdnaD7XwhHWfaBHRin+Pw529ZUbRwB4OHYXxxhjPT
 rWr9zyRPZ4DweKh9luFR1L1CJKe+K7qyb/NePzb/6tJejaGhRYT+f9Dp3oO9Yy2wNcYFdTHmLZp
 reuvx6G9nIdgstYU2ui10KkqQL50L5zAavdWTgX6qFUm4s4A59/qP6+X1VbQAb8wAJFt/AXKtIu
 YE3QY=
X-Gm-Gg: AfdE7cmn52xm4Nuh5S5IUospPUbKUWXPNayNPIUDu8DusnILQWPz4RFay5h0CT6eDf2
 cSqiLekkccdBTu21/l+Tvj0/4dpJIK+5GvlcEL0GoLYUoptwlKFcyjv6GdXfGJJz+avEw+M76S4
 /jghTCd5g0TArE4mldR4gg68tfChwt4LkefEpy8AdpM19jMWpmU5w0CamOBy0dnoWN+cgIQxf55
 CTekPhH8UbAsVCNhIY60fbYIxlD3iWxZdVuz3yv8qaJYyeNjwLjWylAOq//nkV82/MBWarSelmF
 OzfFBcZk2yewS3lXxnPhU+FNagIeGlu7iN+5skZoLPLxcs4ssJfBFxk7QdUJJZxYFotHUfAbVED
 F4g1TkPOsoi5igM2hZbC4M+KNTVtLNE9ZpQQ2
X-Received: by 2002:a05:7022:f68b:b0:138:4fb:f284 with SMTP id
 a92af1059eb24-139eb163fa6mr4419212c88.15.1782592889645; 
 Sat, 27 Jun 2026 13:41:29 -0700 (PDT)
X-Received: by 2002:a05:7022:f68b:b0:138:4fb:f284 with SMTP id
 a92af1059eb24-139eb163fa6mr4419183c88.15.1782592889122; 
 Sat, 27 Jun 2026 13:41:29 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318f3sm33653900c88.2.2026.06.27.13.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:41:28 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 0/5] drm/bridge: lt9611c: improve HPD handling and driver
 robustness
Date: Sun, 28 Jun 2026 02:11:15 +0530
Message-Id: <20260627204125.3334834-1-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfXzQjVRxA1QqVS
 7hlxy1/2TC5a4/WGVTnwI0eW5IAx4MRnz34Bfx4lFp6cy/3mktexZs3PXkQ6RPmD3ylqPxGUSsU
 wC4OxgHxYZSZ35Bkk0SEnNSy2TUeSV8=
X-Proofpoint-GUID: w3GGQmwHwAzMJh8rkp7TZXy269KNsn48
X-Proofpoint-ORIG-GUID: w3GGQmwHwAzMJh8rkp7TZXy269KNsn48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfXzK7WB/ZO9ztG
 75+Uzm0GstJznju9k9THaL7zUrxOhiNK3GFe5aeGbkHtT++1GKo7jVLyig/XIyCPEDmN95dqTmd
 suhjQ45wHSXGQ7fk6E9wxM2HEuwjW+XRdl94x8iulXgpwtTimGmEpfuh6qYtF5H2I7wCJxpeyBn
 rgGVusYgrmqZF4XHhdDc7Dp9ExP59abivmiLmB2WS+5WNlC8lZOvahOBab/LQRb50cPIRYUylCD
 CdMVii+ntm3aVHUzepd0kNu3rog1+tJHa7o9n1Xo65VGRKQeg6aeUdkKKdchgXjzQnNUKUOlsjE
 cDpifwSbOx5oZj/uKgmnhVGOVahKzQjwzJCn6tjyoqLntMDgvHQK21Cyu0YuZiUmJvyvSgZe2Kj
 Scb+0Ht8KAILc01m/TvpIraySCTb2bJGAZn7q4UHF+w1jVfBs+Guv0bIJjTypv/2w/pid1Atlso
 iRI8ZmchaKfJlex/NYQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a40357a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=uxIXVRn-lxS0ewNwCQQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270183
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

This series improves HPD handling and overall robustness of the
lt9611c bridge driver.

The HPD status read from the internal MCU may fail when the device
is not fully initialized, leading to spurious disconnect events.
This series mitigates such issues by falling back to a cached HPD
state and adds support for explicit HPD enable handling.

Additionally, it fixes DT parsing and bridge refcount handling,
corrects chip type initialization, and cleans up probe and remove
paths.

Tested on LT9611UXD platforms.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Mohit Dsor (5):
  drm/bridge: lt9611c: fallback to cached HPD status on read failure
  drm/bridge: lt9611c: implement hpd_enable callback
  drm/bridge: lt9611c: fix DT parsing and bridge refcount
  drm/bridge: lt9611c: fix chip type initialization
  drm/bridge: lt9611c: clean up probe error and remove paths

 drivers/gpu/drm/bridge/lontium-lt9611c.c | 39 +++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.34.1

