Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940FDCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E850010F4C2;
	Wed,  7 Oct 2026 08:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyAP/4DG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bC6Jbnps";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2B310E555
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:44:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jfvb1873620
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Q2lUZd+NOfLas/RtnAkzw273rfkO78ELCSZ
 QLywp02A=; b=TyAP/4DGiPiFXCprcFD25S3Rt6kfGNvgmPPLexn2xQZXcXAygF0
 YYQjKKblQzJXt7Gbv7l5P8qunV4SE3UISmQQoNTi7gnjlh9nnBGP/2eZ+BUvui8P
 QRl/3IB/GfkGv7mBTwCvTQCYn5k6IFSZ3+xWPs8LuEU3KdLgJhh9IjtoxNgEDC0p
 tB99M0DiCcACT5gsvInGqsAHl+ElXZpvUG5z/pKPOyjEg4W0x4Yb1cZSBQVMEzVD
 rAdh6cnCVaSxTGfUrBDV7D7YVGUwjGq3x36ugtEd/KPo3jNOznp2qjjc1AcFtNSy
 6e49pdJkkk1iiZeS5PLQpUe+vaSGuUpO3fQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rkn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:44:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so4546252a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791362695; x=1791967495;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q2lUZd+NOfLas/RtnAkzw273rfkO78ELCSZQLywp02A=;
 b=bC6JbnpsCEqZdoYAj+1tJ9FQOHah8rattye/HXz8yuhybA8sDx+h1lFL8nb9PhQZWN
 Zodk/+E3OCUwNshmRP/TWNAik2l0WfOPlYBN/0KXbWhr69tHqDQAHH6SSgBQfCOtcYJQ
 uED9eisJS5mRgUrdlxihLnKtQA7yyrZ5VMAQpUMDk4VtYgtZ0FLQuTj7tZMkOx/vZkYm
 ++eN6RB60LjOE0S6uC5zsiZs82ybEe3yv7KeNppyB7IkkZ4pZpoGsMGka/TpuOjEJgkN
 btS5UBV68HZTcT6ERgPREdgxGbTbCaSkEqt+k+yo991RWSzT+RHQbDK0Uw4UluStbDGn
 N1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791362695; x=1791967495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2lUZd+NOfLas/RtnAkzw273rfkO78ELCSZQLywp02A=;
 b=Akj74WdnGq0+bTQIm+OWFognVZ0RVy0pyhRg5ehYt/m+5d9mv/pXtfS7SXTWLNMD1O
 Issq8ZDICsF4WtdWTSw1OQL6+OMiRgKeNL2YLnje4wjIgVUDdGBRaBOchZXYZ2shRTjE
 PdPFnHNGea29d08zPOR0Ll+WpdGLrKK49f58H3Y7XfAgIR2qd/D52WZuTogFe7RztZlx
 ZpMruqFUnTJp2skRE/SqrEDW5ZX/5ROn9+rdfTXlTDKFPz0QfODZ7k/uV42roo86CkXo
 WQCUzYYYPobeZqqkpNWg598U2IxJKQtWUMYj03xWGTZ/u5FDYDlLbyqjRILwV1yJK1Mh
 e74Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8Cksn58BNLkBQGhZjosGmuRQKymRY13Gfj0C1qwfnhX17AJTkxI5knzHX5B/nAfWfgU/l6EKEIRE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nni8rzeNmYbHFkG9SVLN3tV3K/bMk1zx3AuOOkfQ7ySTZrLvxO
 xe8KlVrqjyRE0owoOzxAzFkZJdHmLjTfPgGiEivpnhp0kSF7/FXRKC3PsJK5VtLK+3jmBb7iRvq
 N5AmddDytfuPzaVUamoCNmbroMxV62bqK4VAofgrAq4AIdaL/REdIeThGz4JglxW4OYsYBvo6Qm
 s6mUY=
X-Gm-Gg: AYBFou1W80S7mYn0ZXLqDteJRaVbPfWBuWotIE2RcpcXtr5uGolfEIjpkeVcd6dKu9/
 fbxfNxcEMmFi0lCyiu97z/mer1NS5Jm3SeXuLj4z7Thmmo4bwhxfIt9gWgIo2L9lyxMxbd7nP9q
 wk442RFmN0JVyjtjiC7Ky5Z/KIeqHQ3Zc35x/tpGMZ85sArk/N5zbhYqnvxnqr5fygq/wBnOPxE
 ugC8fM/dLL1ogCa4Dy0P02/uMLS3rNJiFRMmw+Ya2qteHq6FNJcqqOc4SVuNxZNgnFud52F6HFV
 59wSGl0h/S411ZjxrfF+s2z5XcQq2qtoNgOJj7EhfdQMohLKYL02nu/rAwuk6hZg6sPQU3FMNnM
 UJmX8JW9GQpeomy0N4y4RT3D9yKFaXAfwJ4JI7gfA4ktTSDcjWGU1Sc6xvz60b9baLFgQvbk=
X-Received: by 2002:a05:6a21:110:b0:3e0:c961:b5bb with SMTP id
 adf61e73a8af0-3e134110119mr1287577637.66.1791362694655; 
 Wed, 07 Oct 2026 01:44:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:110:b0:3e0:c961:b5bb with SMTP id
 adf61e73a8af0-3e134110119mr1287555637.66.1791362694237; 
 Wed, 07 Oct 2026 01:44:54 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8b0616esm1075091a12.6.2026.10.07.01.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:44:53 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v1 0/3] misc: fastrpc: fix UAF and Oops around SSR teardown
Date: Wed,  7 Oct 2026 16:44:44 +0800
Message-Id: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX21Yt/OR2h3a6
 0Mbq+kXCectFoeQoOEHIi9bRy2r1mKnum5Pd/Tty3aMsDa+YvOroYunPPGt3NLhjd+UlbwlM1Vy
 GsNyqhxmCURpJ3sTjsK0iU5lNO7EqCI=
X-Proofpoint-ORIG-GUID: nf5GbrTzAPuxu4TsFtxEIxdIidEAXzv7
X-Proofpoint-GUID: nf5GbrTzAPuxu4TsFtxEIxdIidEAXzv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfXyK3nmgm7v9LK
 sRQAOR+4iaFCVwwOgewdbo0lLK34sGMhbfbiXG67EhyCd/s5CrvMG6Hz36Xtv5YUBS6pel0+OGD
 6TTcwvUxQPHzcgtZ+exu50muQV9MFYmEY6pWT2v5w4WPEefemdS0wJXO54auBrNKB++YGTHKZ5T
 DqQB7JcWfTJw+E+GRYnvgoFxK3/7EKJHTTFY3CIbFIYA9w6BSd3C1dHNZPwQBTyLeULnGSXG1oQ
 IFKZYXzlVda4uuMjMeF2CNmcTfc/dTnzROOKUcbEtbPvHMG3rys2QD6+7E3uUVEmfykdX5TFUV4
 xdawsL+gS116r/bcNl1keB8xG0l3+JqKwhc8twGvUWLpufjZIXeJMmFNZr9XVAP+WduPXWGz4qa
 GXlKRnVR/Lw2bU52jdNkFQTecYaVmLZgXzbpURH2qMLkhmlu8hm4Ac76dm7f+vUfFUXl6W5Zt8a
 YAh/iK5PB9qzqEeFEbg==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac60687 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Eij5vUOpqSaEUsYIQxMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070034
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

  1/3 is an independent probe-time bug found while debugging this: the
      misc device is exposed before the channel refcount is initialised,
      so an open() racing probe hits "refcount_t: addition on 0".

  2/3 makes fastrpc_notify_users() wake poll-mode waiters, which today
      keep spinning on a buffer the teardown is about to reclaim.

  3/3 counts in-flight invokes and drains them before touching any
      channel resource.


Jianping Li (3):
  misc: fastrpc: initialise channel refcount before exposing the misc
    device
  misc: fastrpc: wake poll-mode waiters on SSR
  misc: fastrpc: drain in-flight invokes before tearing down context
    banks

 drivers/misc/fastrpc.c | 63 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

-- 
2.43.0

