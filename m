Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QImXKpdC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z8nEeez3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A9610E07D;
	Thu, 22 Oct 2026 02:35:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B6110E07D
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M2Xfqn3015831
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wO2JUr/7Oi69Jsq+qOpX+DQVSRoBTZ6KKTr
 lEemvdT8=; b=QImXKpdCrXGRkby/CbBI+KGvwR3+OwrAqV3tQTc0WwvTDuK1mtx
 bs7yZk8X7crznyMYlwX6DVULxm8mOJfNJLz7RmJ3LBCksK+KweXyDVbhzLrrTHyu
 eYVOA8OYF5IFDPOonEMA89Zp8xS98EjS2jxPpTkCixBCl3e7wPsijPuVOOCdzeuH
 UZSZ7EKsEw/jND4wHfyyxN/zail/Oyy9n2fA4R47/86CXcrIrlGfg4Uj1LUBJp+u
 ol4QrBPwHI95XqV2VzXUF8vczV3xdBURclzvchpYnuNawEQ6843Nk0UluHUGicOg
 DV0OObVCcc3RvQK/ULLGg2P59u1r/XQ6fgg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93c88p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad98380ccfso1316223a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 19:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792636538; x=1793241338;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wO2JUr/7Oi69Jsq+qOpX+DQVSRoBTZ6KKTrlEemvdT8=;
 b=Z8nEeez3XbBQ6iE2HQl5zpF3vQDTgpVrjtxS26HzDIP8YdfOVkjcbchVZYMcgJSIPP
 ODeuIRfBlDfalr3op1CRPYY3Y63kbXqM7ZZVg0g2oViCtZ6bsKkwgAI6sPXADakGN3QB
 hwzjcd8OCA1cQ/0mnYsQLYRTaZQZfrTUtD/Fc60lHS0jRToiz06WOH6tAJE5SFpevagG
 A7hXqhNno/DnhE7NmzFhA4k67KUUyPjs2hukhq3Ar82LJtKZJtcwJB0doX1OHXe4ZYk3
 fF+iFjzC/pzWQo89lWiX5yA+Uj3pLjy/L8aqB1dpzAI/x3MFpjfdrV0vO3TB7Nz4ZugC
 OHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636538; x=1793241338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wO2JUr/7Oi69Jsq+qOpX+DQVSRoBTZ6KKTrlEemvdT8=;
 b=bCSGL3xXKe0vzviAlngkKJQc1cTbRDbSqXGQoRMyJ6FVz83uUWH74lYKbfak4iWNbD
 Z1HohOscAvdQ3xR3mgyNa/NCapju5fJ+WxN6Ze385ZCEDv2cC3vwTj7bJRQPES36C49P
 P1ymW3sex5Iwv/19WGLZ4AlzyuCZYBqzSiXY0+A7iNJwt6xwUDyxbxiNnSg3QSkaUc5E
 BA1n6ilHfDSriEHmbEBFvHhN6+Pc3jw9j12h72Agp4UXkXgFCehsSz2BuRTm2UfrCPkJ
 XlYxxZUABsTEpnJ74ofQNks8DVxvmbcb2tAOe1c7PbgWD4Qw8KFBpIdV0gpFCqEHHo8P
 CT2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuyOnIR78JK0D7h2/ZFFItzPl3JE51GgKmMNfQPGqLyuFgh8XTdvisU2TTPHRhqEzGBaOEBTsXJTQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJajsoPFmScNJjwwaZE+Qp7qLHtrrUicRd6tVUW+5SQ+elQswce
 Xve6Rar21OxOdF7n/axS0Gm/kTttKBT8MregVxo0SezQSGIwUQ9nDyHM5uSbL8BnIXQQCjEOFmF
 OnWxgN8QecFIsGecvGWHrVCaNIN5pCDJcAFTgM3zpC3EO4gkv5P/xDThkI5i1UgIiljOb7rc=
X-Gm-Gg: AYBFou2LjC9v3VQOUHf0elc5q/HxpUDcRWRoUpqu1OrIcKRFybhlfbxQ3+W70lEK/Yp
 1PPfYvkqqjpqzXwt7PVU0wzM9rsc+Wv98JDwFDq+Wmx9aTPFdk83yfzRBBaTRq+pfL/5h9GNV4o
 AzT5BtHWN+SdpaERk/TDVc9y89fWPVYRBJrj1tmEsKq3BTIMXQ+6V4fyv7uwzf7A+jcqPNtq3Zz
 /T+wW27eV2eW6K4QLN2XVOjRxOWkYHmeLM3C1pMU/EIAkR8o8repN+y9KWtmVMQk3InNWFJYd3a
 aX2OmMxxWXwipNza4jwNUaUBmNjZgXs8R/ZcrmauYAz6/P8/CQ5A65E9n1xzRdd2s6/vAyAg99G
 3An8Ib2QCKDoLdr0pzXN98mTJBjMgOro5SCVTXhwTva6mvSrdESO8gINQl/t2mIepUQMYneh7
X-Received: by 2002:a17:90b:53cb:b0:3ab:884b:65b4 with SMTP id
 98e67ed59e1d1-3ad870a3362mr3274120a91.59.1792636538462; 
 Wed, 21 Oct 2026 19:35:38 -0700 (PDT)
X-Received: by 2002:a17:90b:53cb:b0:3ab:884b:65b4 with SMTP id
 98e67ed59e1d1-3ad870a3362mr3274086a91.59.1792636537687; 
 Wed, 21 Oct 2026 19:35:37 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada488550esm1959935a91.3.2026.10.21.19.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:35:37 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v2 0/2] misc: fastrpc: fix UAF and Oops around SSR teardown
Date: Thu, 22 Oct 2026 10:35:29 +0800
Message-Id: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfXyyhsc77Xyb4W
 SAyQuUTe+K99Mwx3iG7jS22osazsu5l9xbtJuHaxtezdan73CdPvjcrZNYyhvj82vJSUMwkVhZC
 6JOZQyEIrYNrwXBLBQlnfO2JG8YYqcU=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9767b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=BpxS1hBXepmEKCCl2oUA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: a4mkc64pVAUWxROUNjcqWPE0AQEGlzu3
X-Proofpoint-ORIG-GUID: a4mkc64pVAUWxROUNjcqWPE0AQEGlzu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfX6g7bz8mq+s5U
 nlz+8w2/qJGgn6whQLQcN+7GAXDWqRQdYQhg8rp392qRuM5JaYQkqGSRwp13DF7fCuPqRlzT1mQ
 ad+Xzt1vWSEubiz0Ioua54W90HGdH09x+EVrhP61aZqP2QCaWkCsZstFSEJzg2uC5nKqMn6U/bk
 UxvqfXSnAuwWTIROoKxbWe8xLJ3zK5X+7sgf+IlVbxA2ncxlQ3BpvpvOGXJNrMYO7Ft+0+/9B/i
 b8i7ajgf3VlkFEaMtBZLCjO1X6eh5v11ge/Vzu4gCFCVLoq7cpzON9bYY/5jb8cG8ZdR1+PF5+p
 UzHH8SxRiBzCKhseSTNfHMxa3s4ML399Msq1ORFJQkvBc6r6wflm5LjaXGH2jooV3gEkbFzpIfL
 p+aQALGh/8UqFy9FpQhd+tdb5SxQRcI2qoOegkVk/1vxnrg/lqFVmWCeolN02sCKsZ7mS3H4KSt
 bPtUyi9L7MGlQhXo3Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220010
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Hamoa (X1E80100) IoT EVK the ADSP can restart repeatedly, and every
restart has a chance of taking the kernel down with it:

  Unable to handle kernel paging request at virtual address fffffdffc1ffffc0
  Internal error: Oops: 0000000096000006
  CPU: 5 UID: 0 PID: 2766 Comm: adsprpcd
  pc : ___free_pages+0x24/0xe0
  Call trace:
    ___free_pages
    __free_pages
    __dma_direct_free_pages
    dma_direct_free
    dma_free_attrs
    fastrpc_context_free [fastrpc]
    fastrpc_internal_invoke [fastrpc]
    fastrpc_device_ioctl [fastrpc]

The faulting address decodes to a struct page for a PFN that has no
vmemmap backing. It comes from dma_free_coherent() being called against
a qcom,fastrpc-compute-cb device that of_platform_depopulate() has
already unbound: with the IOMMU torn down, the call falls through to
dma_direct_free(), which takes the buffer's IOVA for a physical address
and hands the resulting page to the page allocator.

fastrpc_rpmsg_remove() wakes every pending invoke with -EPIPE and then
immediately depopulates the context banks, with no synchronisation in
between, so woken threads race the teardown on their way to
fastrpc_context_free().
The series is ordered so each patch stands on its own:

  1/2 makes fastrpc_notify_users() wake poll-mode waiters, which today
      keep spinning on a buffer the teardown is about to reclaim.

  2/2 counts in-flight invokes and drains them before touching any
      channel resource.

Jianping Li (2):
  misc: fastrpc: wake poll-mode waiters on SSR
  misc: fastrpc: drain in-flight invokes before tearing down context
    banks

 drivers/misc/fastrpc.c | 61 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

-- 
2.43.0

