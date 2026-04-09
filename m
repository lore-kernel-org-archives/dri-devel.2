Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E2DE98FCD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BE910E3C6;
	Thu,  9 Apr 2026 06:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ti2zcQoN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jnKReMNR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E77510E3C6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:26:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6394TYkT253960
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 06:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=shontEpkN+VyNwHrAxM7Bh6b8F8XkVW6TSO
 Gp+P9W6g=; b=Ti2zcQoNche4LFMWGOwpIk6RXNyMJi9ZTGNh53QzM/+kG8hUViz
 vMQGytepK1h7BDd6Ye52VDHQS/Kh0huLaNc74YNfgACDsc8Ipm941tVYpXz8XKR0
 XGMtDseS9yoTe9iJmdHDXKywM34PWPRPC0GnxBXIN0yRdYJtG8s+08m9LElzx1jC
 rnOeRM4GGoHiT/YVR6RWptL8mq7TkC66m6VrZL7MjTzBSNinz8jNpC+0jKm99+9I
 HoGC0EvcM6Iz/O7DuHf9jbryIi/8Dk75jN21QWVbNKujAu69Ta4RfMZefujMn/oZ
 cJ2/4NnXyQlH3E9QOCD+xdRbPPSLZJnVm3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt6yaq9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 06:26:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0cac007cdso6361425ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775715985; x=1776320785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=shontEpkN+VyNwHrAxM7Bh6b8F8XkVW6TSOGp+P9W6g=;
 b=jnKReMNRlvBlvxVHwuoMhjIJ95FrtspZAtAn2MzByPdV1X7WvugmHE5tP/0PwkWjwC
 IukI5i5Q5z+OgYWFuK/jIvV3EvA8JC9kqpd62T/LV6jwzfgg4AdY2TjL7AO2kbHnwWNW
 mGmWDIahN4V9+ruA8NM/5BZGVwK50MFYLhEWT6h7DDyNmQOkDcXIALM83MntvXlkcdwC
 eRIzKNnDV2O+mifnak9Cx3ejwqw6DGmRGpPOpa4C/4Es3BtxgFchYtHKEqzIG80VaHBM
 68WNWqUpWdn6xR2UTFWUCXRXRpmRjahEIvALH+wQ+NezqN5KR1ouWLMg7G556WfTnsrn
 Gg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775715985; x=1776320785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shontEpkN+VyNwHrAxM7Bh6b8F8XkVW6TSOGp+P9W6g=;
 b=WaPCNdM+wb/rodllEqb+QqQ7w5UkxpgaPU2USWUAI6mngyT31CAfwiK6v19OTRlT4n
 H6AG7oNT7127lzDaGEANze1dDIGr24cKoiONudrFnl6n4HuNjj3sbmzSE3BdIg9as8oE
 PYAA+888fn3AIE58cmu/Xbun9P+6oErzRxj2+F4qp7TQO35kNP3jl6wdvFE0Q6IIQMAi
 HgCTOfhn+wv3qKsA/3CCzJxVeA11bKllnalqQ0cLXDpM06Ass5VEqlzyS/oE5QvrSprP
 l3k5tofXOKyny+QUG1xZnicCqsSpAQ62JZh/4VykJFbBU0fBvuj8o74QuIq0DXhc1uA0
 CGww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUOB1zDJrkjaLOe+x2eK7mk8nR1nzl15qlK/42OaZ5PfCYGUmqYQSMfeE8rD0coT72RazSjqZ/LCI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTzQt49LHANxAQ3eOKYz/jFgFCjKnYCtpIVZkVF27udWbfp188
 kr4KLIrpgQEr+0jGpI2YjU0ncK/XDoJaw2ZJJclpjEnGazQW8GMswevTEwG9/iI4nY05PxrKMn0
 1qwDdjFLUjPOMU2bbxnJrHFbG2kWo3QoF1Ww9m8rt4KOXbVUlJY1An2zjsFVeHAPIVBu0vII=
X-Gm-Gg: AeBDieslTX369y6lzbjaDHQrFzQURLsje2GSKohqsfqQQcbB6ZULdCNLgMNHBEjJ6Rc
 UlfoEH4dCQTMR29v0FiXS2mS1jGhtsguOXBkGOcKhpH2MifM3/DmHuPHrWW3+4MVELFXOHUhHfy
 JtPmxQM6dZmK5/V/dvxuDsXxELst26REX7uAFT+WEjW7CE8plPZZ8CLbe68N4K8KOTfW530tX7Z
 M4MDi9NCG/T1qM166qctr0mJN7vF9wobVhMjp3hV9mad+R5o5qcH5h85hpHD67ML/pS38aJpCBa
 0Ld/S/RBfCUW0b8svcNvVlL/MkJuLQtVUkKEnzSu71uyI7ARMUCCxuHWHOGaLoS/PH5GhlNX3eB
 1hgAPNQlFF1urrR3C67htIVjtxdrlZqmoxOu7sIr1+Kw+3kklx2lxxPDpradv6idTvcDcb0YbiK
 sKDWLDLaQqFJ24qm0w6Q==
X-Received: by 2002:a17:903:384f:b0:2b0:b41e:c5c3 with SMTP id
 d9443c01a7336-2b28176a416mr247491885ad.29.1775715984843; 
 Wed, 08 Apr 2026 23:26:24 -0700 (PDT)
X-Received: by 2002:a17:903:384f:b0:2b0:b41e:c5c3 with SMTP id
 d9443c01a7336-2b28176a416mr247491615ad.29.1775715984381; 
 Wed, 08 Apr 2026 23:26:24 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd4dsm220786795ad.76.2026.04.08.23.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 23:26:24 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v4 0/4] misc: fastrpc: Add missing bug fixes
Date: Thu,  9 Apr 2026 14:26:13 +0800
Message-Id: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Uwb-TGc89SKQk5uaEOwoEUntiwXZw0WI
X-Proofpoint-GUID: Uwb-TGc89SKQk5uaEOwoEUntiwXZw0WI
X-Authority-Analysis: v=2.4 cv=R9sz39RX c=1 sm=1 tr=0 ts=69d74691 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nVt4PUt5okI7hfkv_aUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NSBTYWx0ZWRfX0A9RA6fpwVJ9
 4ukudwqafncHQsL/TpQonjAQ20MZxMCyuc7+3MTA8rixvKfqaNFGZ/QM+QLfrVncxTzQHO8GGXH
 sKiZYtmCV5QKPpTAxPpZ3SUbEmE6yrhS+IsdONry9SGHHTAVn1tzY4aIP9QcIpEim7zD2KehZZd
 On/WIDiuJC2HRmLIgeK3Y5vkXjwoR1WTqgbJQD+DJ+o59XUmK7xxIzQQt9elOBY/TDatgGlb8Kw
 X/diznfC/FrO6AmJzrH2hyi2Y+HN8iYSShaA7z06MTs9ssTdzIpjfIBFwvh6teK67SI1OKdROxY
 4Did/v958bdMpaUoXuO3jsy4b1ELugYAtn1WvTwjx4i+sXRjefgciuaUZQ6J+KfDFY0rQ1WPZi+
 v/i+gLnalHJQVy7QMlRvb9cELueFFXRwa/KHzYHJAp/gMCtWGRQYw9e/HGWxVGDTU6iB1aTOVMr
 vpIt3aunUbkO4JikFgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090055
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

Add missing bug fixes in memory areas. This patch series fixes multiple memory handling issues in the FastRPC
driver, primarily around the Audio PD remote heap.

The Audio PD uses a reserved memory-region that is shared between HLOS
and the DSP. Allocating and freeing this memory from userspace is unsafe,
as the kernel cannot reliably determine when the DSP has finished using
the buffers.

To address this, the entire reserved memory-region for the Audio PD is
now fully assigned to the DSP during remoteproc boot-up, and its lifetime
is tied to the rpmsg channel.

Patch [v3]: https://lore.kernel.org/all/20260407100508.1027-1-jianping.li@oss.qualcomm.com/

Change in v4:
  - Fail Audio PD static process creation when no reserved memory-region
    is present, instead of silently proceeding

Change in v3:
  - Adjusted the order of the series, placing NULL check changes that are not bug fixes at the end
  - Modified the commit message to describe the bug background in detail
  - Switch buf->list_lock back to fl->lock
  - Add locking to the operation of audio_init_mem

Changes in v2:
  - Remove the if check outside fastrpc_buf_free
  - Store the spinlock pointer in the struct fastrpc_buf instead
  - Allocate entire reserved memory to audio PD through remote heap

Ekansh Gupta (3):
  misc: fastrpc: Fix initial memory allocation for Audio PD memory pool
  misc: fastrpc: Remove buffer from list prior to unmap operation
  misc: fastrpc: Allow fastrpc_buf_free() to accept NULL

Jianping Li (1):
  misc: fastrpc: Allocate entire reserved memory for Audio PD in probe

 drivers/misc/fastrpc.c | 136 ++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 62 deletions(-)

-- 
2.43.0

