Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD5C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D43E10E32D;
	Mon, 13 Jul 2026 05:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/IOHKSZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H5F7j/fl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E1210E32D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:44 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D3A2Mu169676
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qPjS1A0Zh8DHuBLLvW8n3u0p7R2socgS97N
 yLVt7XYc=; b=Y/IOHKSZzU1yQStBFlWhxIyYE16pX9Ky/HFUf7OYhG2u5JSF5kk
 pCHdS2+3eGaEkZqUGxt/jpoFEfZmoFWUDfWLeZ/7x0VclJCoq0F90UdLuABvxR4W
 NpslEtI4nw1jrgRtYGidPObFu45IPD9HaxA1EibjERjqivUkXMck6v6VWOA0YLSf
 CaPBfDcuHWYTUQTNstkcMCMD/CYQ7Zk+143LNv+1wKDq64nbpBkSUj8h1HFaSAp/
 YmaELZVTupq4lxCFGtHVjsl7/qy0v2dqq9zYvaiIhk9mgApPf4NZC1hSd/UCys2K
 IhrS/CkBSh5OFMK/eyx7p3URiSZ44Ng1WLg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehmfnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so1235075a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783920162; x=1784524962;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qPjS1A0Zh8DHuBLLvW8n3u0p7R2socgS97NyLVt7XYc=;
 b=H5F7j/flcYuMpK1jET5L8NaA4g1xD53otHV++BGgyj+zH19PB0gFFfCOBO1xUMp7B9
 7XbgaJzCj/nvutrO/eDkJDnmofP2P/mOxOYzXTcDjhWIHkwzxtcJnQsKAXvTUDiHsA7v
 4QX6alE+4tI3k3fiIUuXAXsiyYsdSvGAJE039FJKiuJyLnZXoSc7l0T5etJ8Vlw9KR50
 lxH4iskP0W/XIMsaLpt/p5vX/wKLzuaH8ItN8DwucNv3xtz5abmL6th6Jbc7QKXh307L
 zRLTU2uMtnqEcbuR1IEquWxXqgzgXJofCevWMeT/5D+m22VoDfv0t4f60QiGOXuQ1M1x
 PLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920162; x=1784524962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qPjS1A0Zh8DHuBLLvW8n3u0p7R2socgS97NyLVt7XYc=;
 b=Elg5H4mhyc1zG2Zps+obS+a+s3jIMSSq1+zvFaeZPvvKaI45m62YH8Sd6SX9EDdINB
 aiLfUGLB4c4Bj+Z5ekivYxRLTpnhiiApL7qgbg5miBeqMhfiX+t2JkBPlpHV5Ecjr6Nb
 gf20CXf57wSsoi0TTFnh9zsC5FkW35oyN4d3VMklq4RhTllB8ACMEEnSrjPJ8rHXjLfk
 dEyrPi/sNXQERQRC8zr7ouJekshUFyLd5tNPpfkwqFgB2Z+RYoeV2+ZhbgCgqJmOz2TM
 XrjAt4/2NxTDH8ZeZUfaVmMMdxQ9Nezm2D2Wl0VL4TQTJFAVH9p3ArVQpk059j5PkjRp
 BNDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXkRi5iuhvimLhnbdWTH2VSgqnWW5K/A0kSwv42p93d00i+CffiBeEs269TWO7Vq0xscis4Xek6UI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz63IiiZ+dPZC7MZMueLVrlvXq6JrOwyDx2XgG3pBbx8j+lZlhy
 m9BihTo8IMHj30zkJItSBKjEaLjWA3vu3IlHDIXbzCzD+5TDU5b0iEWlyUHm/2j8gQDyOKFkxGH
 wlpBEEzdG9owNoe4wkdEWthRJI8LpkBOl6hkcXQ4o0aqV+hljU8CvF4UgOsRk7ckrV0ViMZ8=
X-Gm-Gg: AfdE7ckVNRLhnVQtjsPro18y5q5l4G3MmyEjQz+Vi6mW/Ln+fwRklvSzQrcpZayW60w
 AiEn7QLkEpMyOPhdEhEv6rAL0oXiNPnPDKLFUCPiZxFYeX7Jt0pxm6EF+A4ux0JDoaBCksWP1hS
 CRELalkieDfdeSTLKVVpvwFHl985eB8uGtwcdK3/ivpmRe8oVkGGjIihKrBBTLY03ClgcAeflce
 zCEKPRZKeItjsSsoUum9vlTSsOvcmPRA0rlhMtvE6FPY5/dEaK3QYa0Qwji2u/YhWSmsCGYJkD9
 b2q2o01pBxjvH1SCtg3oj1DB7VjFSJav8mJFr8HdjIQqDTKHODB6uMoMrfEG1FxZRFtPSpazd9K
 n9zFVFK88gpbs4E108BWT9I8NRuIKLi+adEXpxtaYUWU=
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id
 adf61e73a8af0-3c110b35019mr7630849637.74.1783920162215; 
 Sun, 12 Jul 2026 22:22:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id
 adf61e73a8af0-3c110b35019mr7630823637.74.1783920161762; 
 Sun, 12 Jul 2026 22:22:41 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca75ef0c30dsm6245605a12.17.2026.07.12.22.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 22:22:41 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v13 0/4] misc: fastrpc: Add polling mode support
Date: Mon, 13 Jul 2026 10:52:32 +0530
Message-Id: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfX9x/kNx+UkLw7
 rawrNpPGRzBe4tP/gKlksHBHAUfwFOPQFweaIo8P015McruvS65r5e7setjaZt7lBUJNktJ6hRI
 hoxCtQzbtG3Dl9hZ1Amm679cPuc1z9s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfX+baDMiMAOtpP
 FlfBBMxmT3cM23QMIuIPHFzdweg6yztHJwb9Fo/i1NRzoAX/NJ7He7801tJyoR9DwVXr36ORn8q
 FlYqiJlZflXx6/LllhFNoTcC4wNKPBTOoehwAeWiT8gDc58a6/UT9Qq9bKQXSIrp1IrFMWUjPOl
 tQ+S4gr9asZxwZXkyM16SRdGzG02h+VrX04euqo11Fi9CtusUeBZRRk/iwZgEGpDhdaARfFgsb2
 mMCedaE+Vw540pu5ElRKYHuGOT0+WRoxO0rz2VunveD15OkaL/7fso0nLRgH/O1WZFtvfnnC+TT
 yv95OUc0Z/DpZn03rXK8aTHAJlv8R4IsCO3LlaWsJYSQTeynhb8HnflGkfSPR/Caj6X2N7kZ8P7
 +jRkkOkCag9w+GMT23oOK6nYSdpfjPCXOf3/qGBfU8DXMoj3xTNw8krVaRY8HqFkp5bYCIeAJNY
 rZ1ifXxBXxQzZ3JCOYg==
X-Proofpoint-GUID: wWloVF7ghSYd2AzeA-VgIUkGYctI9yHS
X-Proofpoint-ORIG-GUID: wWloVF7ghSYd2AzeA-VgIUkGYctI9yHS
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a547623 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JBkMMMYkqyTW2kI42m8A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130052
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

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Userspace change: https://github.com/qualcomm/fastrpc/pull/258
Patch [v12]: https://lore.kernel.org/all/20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com/

Changes in v13:
  - Fixed race between recycled ctxid and late glink response.

Changes in v12:
  - Fixed poll_mode_supported check.

Changes in v11:
  - Moved back to read_poll*.
  - Improved error handling.

Changes in v10:
  - Add milos and sar2130p to fastrpc_poll_supported_machines. 
  - Updated comment for supported platform list.

Changes in v9:
  - Added platform support check.
  - Moved to readl as per Luben's suggestion.
  - Cleaned up fastrpc_wait_for_completion().

Changes in v8:
  - Added more comments.

Changes in v7:
  - Fixed warnings.
  - Fixed commit text.
  - Addressed clean-up comments.

Changes in v6:
  - Fixed poll memory calculation.
  - Added few formatting changes.

Changes in v5:
  - Add more details in commit text.

Changes in v4:
  - Replace hardcoded ctxid mask with GENMASK.
  - Fixed commit text.

Changes in v3:
  - Resolve compilation warning.

Changes in v2:
  - Added comments and fixed commit text.
  - Defined context id position as a macro.
  - Added new IOCTL to control polling mode as always enabling
    it might cause excess power consumption.
  - Cleaned up polling mode implementation.

Ekansh Gupta (4):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Replace hardcoded ctxid mask with GENMASK
  misc: fastrpc: Expand context ID mask for DSP polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c      | 214 ++++++++++++++++++++++++++++++++----
 include/uapi/misc/fastrpc.h |  29 +++++
 2 files changed, 223 insertions(+), 20 deletions(-)

-- 
2.34.1

