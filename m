Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C30BCD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4A710E053;
	Tue,  9 Jun 2026 02:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKBQS0ya";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5m7vvpO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D2810E053
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 02:59:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590sNpi1074837
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 02:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ATfqrK83DCS8vP1sxQooyW+tmeEThP3HfRL
 fmcmX9k0=; b=mKBQS0yahjpgtjrb6F2pR9TEurOZkiuuNcMTHNmGkVK/Qa3/bDz
 dJrA3XWIVX98ui6q9mXxk11BYEepXOH1S8FtZi4aoDDX8gkUa+cbmWdMiJdymDr4
 S7799A+6B/8D12n0J9swyWBsf2HPj/yyEiy4Pla0HecngwerxlhHTZvXNKInvrVd
 GJINw6n/k+IlmNedOtWo0iuzgmRaCaeydaKZKDy3ABhUwnv5QbE+PxfaKhd/4YUm
 FJflm8oJeWF7apbl5d2enjiTgWimRNX9tBTs3Pqh1M+0jTxUH6jsXU1zMBooGLHl
 ob/g92+uxR0JLx+1rYXEVPkmhWWOTG7Auvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0mc10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:59:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d98b54cf2so3638545a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780973986; x=1781578786;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ATfqrK83DCS8vP1sxQooyW+tmeEThP3HfRLfmcmX9k0=;
 b=f5m7vvpOxPPwXveUIEU7lpwrmpRYoLbUrf6oqzS7AWBluQYs+vUQmriAOyXJVwgaK7
 Suof+mCQ6B64YDNcWEjUpJWex1lEe52ePtkdvKwFLkyvi5iRhfmNQFqdOi8P9GW8UtV7
 kPMm81qQrZM3yHYZZCDTS8iuF+9e5OyKAianBdy9ONQ6o50uX4m9PmJmk8/AY0XpHR78
 /2zqrdfyfZeoCC+9ZxS7senR4+qFv7DJVz52I6Au8Yz3rfzxyO8z7gA5pzCFkUip/EJE
 B+nAiLooqo0PRHyPd8jIvP3TFoo+AEBnjYlbJjRi/3ffz+3n1MJqE9Is/gEpVu4ZMamo
 F/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780973986; x=1781578786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATfqrK83DCS8vP1sxQooyW+tmeEThP3HfRLfmcmX9k0=;
 b=j0CAiqAMYRtKvXLfCANff6ViFnN8Ff1jX42+Hn9IjLEW1OIk7F+Y5dBr6JrMZN6cb+
 xwXk4dsXf/sUQ89gp7RlvhJqROLZ5r1+TaUur5Sxd8SB1dqHDXsyTd2KHf0SF1NZwP/g
 TSffxoO5OyBmLPGJaKIjMRQ/TKD+BobXYcAlLZ5Qi80beAZjAA6toXhDPYcRl/CywZNt
 /6vEY3HC+Hfeu7NYIGJtsf0pDIjK0lldEho09NxtMIvWsz3rX3HF89safnb69GyRG0ab
 6vZTJ2+vNW4HECB6yfb8UxXtwK3ncU0VcvacDZbpBpRwCIVBUzOva59jem3EGIbi0tmT
 kH+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5uIjk75qaotbLZNpHw6EY0QbNjzsBlqyW08hiDp1QPkOPbQh+K5+XCusZj+1zRtKvyjATWQ2b1Uw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx43KLS+eABryDOgsy8QXAGCmrGcoAzN4vH21xl9Ua5wxx1a7Dg
 bpGevS0GKnfW96n3H4UrkP7r/fRzX9CCRmReEEZ6bxn8pZ8I4BTcx03bjPL26ZsmKKO0F6ZpVjA
 sS7fRhsjfePNOFoFwidQC5dR3lNDhR8D71MYMAROSEvKSAaIPbpj1omMbdVmnY7sDxWX/+M2Vin
 2XDII=
X-Gm-Gg: Acq92OFu67qWxFXY3ZB9kBdFFpRRjn8Kz6bRAZzfc0RfACQXoekWe7U4VNKQ5wOHC/S
 rDAt6PVT6sgjlpbGzbdNyZQESlZjF8LSCAGOTxPy3ZGwKOZjL8hgR6+1AARIDVsFmPb47MvUQPM
 7YXyiagxAR3WiQ6Hd9krn6gdDD2UYN35Hfn66CCQBmZF+s1h0vA6VmcNe5z5bfhxkwk2eqZH9YZ
 +dWvMEzpZaI6Pr1ditHRXh26goKd1cE0a5TrlZ+31PzaiaNLeeSODZO3UnyDjWJFnLZiyqON6SI
 szvGt3ifKCskWBJBMN4ZSbGXIvD7CRXIgmEjmeCQenjq4Ph9tu53YWi4Aa+lv+jTXUTDDlshHYl
 qc4vJVN0L4CCoLDys3o+Byfh46fwrAvPGdg6PDBA56GjmpR/ovmg7jAQMVTiI7H5N8A7FhYLRhC
 jJoxSJk5iDoO4hBdKLc28C3XdLJ/Gn
X-Received: by 2002:a17:90b:4a08:b0:36b:71e6:3df1 with SMTP id
 98e67ed59e1d1-370ee447dd2mr20935868a91.3.1780973986620; 
 Mon, 08 Jun 2026 19:59:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4a08:b0:36b:71e6:3df1 with SMTP id
 98e67ed59e1d1-370ee447dd2mr20935841a91.3.1780973986188; 
 Mon, 08 Jun 2026 19:59:46 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712fcb2607sm8713835a91.0.2026.06.08.19.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 19:59:45 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com
Subject: [PATCH v8 0/4] misc: fastrpc: Add missing bug fixes
Date: Tue,  9 Jun 2026 10:59:34 +0800
Message-Id: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyNSBTYWx0ZWRfX5caALXRpGMx6
 rJoYec3nqOhzVyTqA64t//GCOS4p4KkVC06OBPL7/htQMAk1H0HuznuTqIq4gO0CuYUsvPD6lcJ
 c0TRR38Ew0v5ihmz3C5c9cuAswpP+aH2g9rOId15W+xIcNxiaXe004QMHcFrFkwOM4wJnTCGGs6
 RDMSAioVw4cHFM3lHAesUIIWYL0BaUNJMx27qiYxImxZ/OvoPdTlYaY1WdGseCHSW334NO8Vw1g
 UzdyYGfJ7jIXJ5g0+p731hW08rrHccPQqWnLaj4uG/cgCtHnHRpY2pmfNAnKIS00H9ww28Fqiak
 ZvSUwTwxNUiW8Cxk02wgqf3k7bK/RNmfPXF+oKOw9nDD9RJ6cY16psJ2PUQTE9N0OogQmqs0LWl
 GpZixfbA6U81fhRYPvIczyjC4LWyHYfO9RR0D3un14iq/ZTFqf7POWW+GV1FqqNi3hhHf+kVRy+
 DMmO8OEE+XHKambTPHA==
X-Proofpoint-ORIG-GUID: dvZj_Q3ma-fzsczs9V2qxUHXtiC7ileU
X-Proofpoint-GUID: dvZj_Q3ma-fzsczs9V2qxUHXtiC7ileU
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a2781a3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QQhtNXlrgi-O-yTIfioA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090025
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

Add missing bug fixes in memory areas. This patch series fixes multiple memory
handling issues in the FastRPC driver, primarily around the Audio PD remote heap.

The Audio PD uses a reserved memory-region that is shared between HLOS
and the DSP. Allocating and freeing this memory from userspace is unsafe,
as the kernel cannot reliably determine when the DSP has finished using
the buffers.

To address this, the entire reserved memory-region for the Audio PD is
now fully assigned to the DSP during remoteproc boot-up, and its lifetime
is tied to the rpmsg channel.

Patch [v7]: https://lore.kernel.org/all/20260602071750.526-1-jianping.li@oss.qualcomm.com/

Change in v8:
  - Squashed "Fail Audio PD init when reserved memory is missing" into
    "Allocate entire reserved memory for Audio PD in probe" as the
    validation check depends on the probe allocation
  - Fixed error path in probe: use goto err_free_data instead of bare
    return when kzalloc_obj fails
  - Added kfree(data->remote_heap) in err_free_data path
  - Made kfree(cctx->remote_heap) unconditional in rpmsg_remove,
    not tied to vmcount or qcom_scm_assign_mem result
  - Used local cctx variable consistently instead of fl->cctx

Change in v7:
  - Removed duplicate remote heap validation check; keep it only at
    the beginning of fastrpc_init_create_static_process()

Change in v6:
  - Separate the handling of err_copy
  - Place the check for remote_heap at the beginning of the function

Change in v5:
  - Split reserved-memory handling into separate patches

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

 drivers/misc/fastrpc.c | 137 ++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 62 deletions(-)

-- 
2.43.0

