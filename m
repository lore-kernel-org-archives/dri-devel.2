Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B1606E511
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OZW+3PCf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hYjriyY8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C3F10E49A;
	Sun,  1 Nov 2026 22:21:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF6110E484
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:21:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KKbLC1246709
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=N3RWATaB+aWOJihIl8wvlm
 I7dxCvdo4R4nH3ZaI7fPM=; b=OZW+3PCfS8qcXjk4AralCI+AmZxQL6oVlV6FYF
 qAHRRJffamsDNh90E+KfmEelqLvEnAny+QEHyO7CNKU6GU7SwFvEHVy3UPDDn23s
 PF0gPjvrMVQ8gTqOah9KpJk7y+2CU5KL0bc2s56G+Og+uvtVmOl7irkZYR2Bb5i5
 bziXlObmkXK2wXT87SrOy7oAMi/OgvJgWbdDwceWpZyweWMoZR+cEXjBIUcBtUIn
 RWd2px5mazIESV/TyG+jpW7Zoe1gwjXwNgRbEUXA8QNp07hFRVVDwh6zGyqHwB7V
 MQckLD70hbrehHaR+IHAVNRYLc4k5SVfAGWjpx/H5ZDOsurA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93em5ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:21:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4789619eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571691; x=1794176491;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N3RWATaB+aWOJihIl8wvlmI7dxCvdo4R4nH3ZaI7fPM=;
 b=hYjriyY8zObKkfMpsv9r3JDetGrRbgI1jnSeKLr0xCZf6tpdsJTHGpV1e8mLyNYh3W
 puyY0KbBtspW55jJjKnvUnzcpBYjs4ZTFGafcemOjFCDfOeGn21X6wfB5HBP12nqVwzD
 ra5V3b2XsAsbRyaQSEsdlCr5h1ncK/DS+qByL5cDoLh/nytFrPljeg+Ha+HxvzuuIU8M
 1lbCDoYxVB2Nvwt19klwGhGVmyry2I8DilGsWl9y2h+LHkWapozHhzdz4rc4+GQLZrbC
 jojZBSOZzzwBkq+x5YO03pEqrLSGI2ZktYt+lffjmzIJeb5Hok5KAkJTe0fc5DAsQtcl
 geHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571691; x=1794176491;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N3RWATaB+aWOJihIl8wvlmI7dxCvdo4R4nH3ZaI7fPM=;
 b=pn73kqWixkRQQZK5poI0JOdbSgmYYtbQGWMB/5t3NKX20H9a88s2YvmIxkQBYzANEd
 dWXsPtHsuBl3d3C9wnPFGrjIucLz3fHo4hSt3yIl/Ka1oOQFTkl8ZeeDU/6g7P5swcmB
 5xG0NwKqEE7kRDJYJVEVWLf/VTA3n/POG3UeO4VroxSkz+kKVy8ca9NGvxnvEU9bzmnc
 o5lz+foHHBT7PWp1uZFTQve2bCZRnnwu3n/aLxeB0bVhx6KlxcLl45ppJnfPCN/J+cPP
 0ymTJz/UwYpddnrxrVpd5jLsauLGMASbMUsF5pfo7e6Q9uysuA922Vq/Wwr3xG9HOewX
 sQmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt0Mo1YeQi0StmjhAmpLpT9/dzY9v1nDeDJWZqJr6FYGvzgJy3/jr81tvEhSnkHTbW/WnL+dZ7V8E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIWFbE1mifjf7s+P+LxAQDkMVLexi9AqGYlFHTF728iSuE1mOcu
 /cRvUVM13kQTiE7ywIE3tlrIlAaSbqdx385OwaXFDSZfCX6YxHmoTb1HO8ZQK9iCSNI1lf+3W6E
 CgLb1FAdkkBB4UUgg7VdBaTzJPRMAQRrhMRd52q6nG3aPGB9Vacrh7smuQ/QcjopFpTk4+ig=
X-Gm-Gg: AYBFou1OoWWes5Wj6JVcavzRn+qNmmOE0dr4c9CRn2opmY7wIoFx4l4ztDBASI80q5d
 rE5AYveRgGMTO2cUjSWXL9GbzFwUWy2iUTkwnTWtA2O7Hh/Rm5fMVQ7G3rql9zw8RZxErETatpV
 IB897qMfUsF01fpqJeVWPKTmh6hzEyZ6dztRhlKvIbbpRyXNI3dUd63V8H785U/IHqkKQECmFag
 T4aQTKjVtCwgFQxf4hT6xgB0fuqf0tnRyks4YoHfFChm2Um+z8tL2M9Epka/1g5k5ttlOWmNUm0
 fOD8U4VXXpV04EJErtoOPStPkCjIi0dC1gOSX25utELeam9Yc8YUZ/UxpCU6fAL/BAfaOi40jdu
 MI/BtOEyfSiicXccvItnGgLqpX1pgFX9HcdGh4O/Gr/Ghpg7DCC3muIWjPgocfnnc+6E5+UCfEe
 UxfUNhnw==
X-Received: by 2002:a05:7023:a42:b0:151:ece6:b16b with SMTP id
 a92af1059eb24-1ac5da755bdmr11225995c88.7.1793571690902; 
 Sun, 01 Nov 2026 14:21:30 -0800 (PST)
X-Received: by 2002:a05:7023:a42:b0:151:ece6:b16b with SMTP id
 a92af1059eb24-1ac5da755bdmr11225946c88.7.1793571690095; 
 Sun, 01 Nov 2026 14:21:30 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:21:29 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: [PATCH v4 00/25] accel/qda: Qualcomm DSP Accelerator driver
Date: Mon, 02 Nov 2026 03:51:13 +0530
Message-Id: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq752oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3TIT3VSLtNQkYyNDIzPjNCWgwoKi1LTMCrAh0bG1tQChdTbjVAA
 AAA==
X-Change-ID: 20261102-v4-e8feb321263f
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=17178;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=7ulwZDRbVbhnX5VSUAXcebVVwrgoPRyLQkWga1KdhyI=;
 b=JjzbJKQ6+miuS0jSAWNVCxpyx2YYtKJ7fEaBtdbYj1dJa110KsuqrVzxhkF/GKf1eq6xv/EOH
 24RZdWQPUInCFtZhzU8M4r9susfH4vy/3gfy+Lz7k0k44OxRRLQaqbO
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX+fHyEWmW56OP
 WZtTfCUx/oLEou2iwMbQOpfLcz0zVgK+L2l8kxJ+X4mWDxRXX3AJwUyrZ1Mjn9lBrJlA5a4SH+q
 RN+VjVLJFHlXSzXGGuGuOX8aGJ0EOSXNM1CiSFKSSG+Yv2qHkQLRkHiijHiQweuYQXR+goDziCT
 sklWUDx5e+s8fEtwyTfuw5Bh66tfOO9aif4z6oMJwI5AH9jR+hSbczgdHRnc1CySxeP7iKvyE+B
 Xfep7hPJnufhozUkCu3SqJP9YBfuHTxb52ftbAYmZVK1tuFGvy/W+mVGHyzIbqSBXb2PkgpFsEX
 9Ts2QItsZGBOFk2x5SqtIDKrvhNLKsjqyyJcZN3I0hpWRwYpuo8BE6+tGfyio4AQTCqxwFreZ99
 GypNLYSmDS9ql8zJxs3Z6QJsDXVq/A+B4mSuGK2Sk1XrTB87IzSqBCXe+qieqnbbMOQaMSzR/5t
 nEjiHTGp21jZUU4HMOg==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae7bb6c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J7Ab9oP_6IQewhk8SDcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: SFey7SBvB5qL_hEQVhgsHMaeZb60tD3P
X-Proofpoint-GUID: SFey7SBvB5qL_hEQVhgsHMaeZb60tD3P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX97pA9Rk2AP+Y
 P0cAktQ4HqSdjRkaelr2w6L82oLANCqnqHfI/RK5EwNPtQYYwmGL6y6HVbWSCP2Yr1EgFElIjis
 AaVsBMipIh2SK6xN5BWxqd4eEgnB2SQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds QDA, a DRM accel driver for the Hexagon DSPs on
Qualcomm SoCs. It is meant to replace drivers/misc/fastrpc.c. It speaks
the same FastRPC protocol to the same DSP firmware over the same RPMsg
channel, and it binds the same device-tree nodes. It adds no new DT
binding or compatible.

Existing user space keeps working. The series also adds a separate
module, qda_fastrpc_shim, which serves the full /dev/fastrpc-* ioctl
interface on top of QDA. A distribution can therefore switch from
CONFIG_QCOM_FASTRPC to CONFIG_DRM_ACCEL_QDA without breaking FastRPC
users.

Why a new driver
================

drivers/misc/fastrpc.c predates the accel subsystem. As a miscdevice it
implements its own buffer tracking, buffer sharing and per-process
state, all of which DRM already provides as common, well-reviewed code.
It keeps buffers in driver-private per-file lists. It accepts raw
DMA-BUF fds, user pointers and inline data as invocation arguments. It
keys state on the calling process. Each of these has needed
driver-specific fixes over time, and none of the code is shared with
any other driver.

Converting fastrpc.c in place into an accel driver was discussed on v3.
The conclusion was to build the core cleanly on accel, and to keep the
historical interface in a separate shim module that can later be
deprecated and dropped.

What moving to accel gives us
=============================

Shared infrastructure instead of driver-private code
- GEM provides buffer lifetime, reference counting and per-file handle
  tables, in place of driver-private lists.
- DMA-BUF import goes through PRIME, the path used across DRM, rather
  than a FastRPC-specific fd lookup.
- Device registration, file handling and unplug follow the accel/DRM
  model. DSP-specific code is limited to the FastRPC protocol and the
  DSP memory model.
- The driver is maintained under accel and reviewed against its
  conventions, alongside the other compute accelerators.

Stronger isolation and a smaller attack surface
- Every buffer argument is a (GEM handle, offset, length) triplet,
  checked against the buffer size. The accel UAPI accepts no user
  pointers, raw fds or inline payloads, so the kernel never resolves
  arbitrary user addresses on the DSP's behalf.
- Each session owns one IOMMU context bank exclusively. Context banks
  are never shared, and a buffer that belongs to another session's
  context bank is rejected.
- No state is keyed on PID or TGID, so isolation follows the open file,
  not the process.
- Privileged operations (signed process creation, and Root, Sensors or
  Audio PD attach) require CAP_SYS_ADMIN. The check is made in one
  place and covers both the accel UAPI and the legacy interface.

More robust runtime behaviour
- Context IDs carry a sequence number, so a late or duplicate DSP
  response for a recycled ID cannot complete the wrong invocation.
- Waits are interruptible. An abandoned invocation keeps its buffers
  alive until the DSP has finished with them.
- When the DSP crashes or stops, pending invocations fail with -EPIPE
  and further ioctls fail with -ENODEV, instead of hanging or touching
  freed state.

A cleaner, documented UAPI
- The interface is documented in Documentation/accel/qda/qda.rst. It
  uses a consistent QDA_ namespace and rejects unknown query types and
  options, which leaves room to extend it without new ioctls.
- The handle/offset/length model carries no host addresses, which makes
  it a better basis for virtualised DSP devices than the legacy ioctls.

No flag day for users or distributions
- qda_fastrpc_shim keeps the existing /dev/fastrpc-* nodes and ioctls
  working on the same core, so current user space runs unmodified while
  it moves to the accel interface.
- Both interfaces share one implementation of the protocol, buffer and
  session logic, so a fix lands once and applies to both.
- Once fastrpc.c is removed, there is one FastRPC driver to maintain
  instead of two.

Backwards compatibility and the path to removing fastrpc.c
==========================================================

* qda_fastrpc_shim (CONFIG_DRM_ACCEL_QDA_FASTRPC_SHIM) binds to an
  auxiliary device that the core creates for each DSP domain. It
  registers the same /dev/fastrpc-<dsp> and /dev/fastrpc-<dsp>-secure
  nodes as drivers/misc/fastrpc.c, with the same secure/non-secure node
  rules, and translates the legacy ioctls onto QDA sessions. All
  protocol, buffer and session logic lives in the QDA core; the shim
  only handles the legacy ABI.

* The core is keyed on struct qda_session rather than struct drm_file,
  so a session can exist without a DRM file behind it. This removes the
  blocker reported on v3: there was no way to construct a drm_file from
  outside the DRM core.

* QDA and fastrpc bind the same compatibles and create the same device
  nodes, so they are mutually exclusive: QCOM_FASTRPC now depends on
  !DRM_ACCEL_QDA.

Shim coverage, against include/uapi/misc/fastrpc.h:

  FASTRPC_IOCTL_ALLOC_DMA_BUFF       supported
  FASTRPC_IOCTL_FREE_DMA_BUFF        -ENOTTY, as in fastrpc.c (buffers
                                     are released by closing the fd)
  FASTRPC_IOCTL_INVOKE               supported
  FASTRPC_IOCTL_INIT_CREATE          supported (ELF image passed by fd)
  FASTRPC_IOCTL_INIT_ATTACH          supported
  FASTRPC_IOCTL_INIT_ATTACH_SNS      supported
  FASTRPC_IOCTL_INIT_CREATE_STATIC   supported (Audio PD)
  FASTRPC_IOCTL_MMAP / MUNMAP        supported
  FASTRPC_IOCTL_MEM_MAP / MEM_UNMAP  supported
  FASTRPC_IOCTL_GET_DSP_INFO         supported
  FASTRPC_IOCTL_SET_OPTION           supported (poll mode)

Known behavioural differences from fastrpc.c:
- INIT_CREATE with the ELF image given as a bare user pointer instead
  of an fd fails with -EOPNOTSUPP, as there is no buffer to resolve.
- INIT_CREATE_STATIC ignores memlen. The Audio PD remote heap size
  always comes from the device tree.
- Mappings are tracked per open file. MUNMAP with a length other than
  the mapped one is refused, and so is mapping the same fd twice with
  MEM_MAP. Mappings still outstanding when the file is closed are
  unmapped on the DSP before their buffers are released.

Proposed plan: merge QDA together with the shim, then remove
drivers/misc/fastrpc.c, then deprecate the shim and eventually drop it
once user space has moved to the accel interface.

Design overview
===============

* Context banks: each "qcom,fastrpc-compute-cb" child node becomes a
  platform device created with of_platform_device_create(), which gives
  it its own IOMMU domain. No driver binds to it, and no custom bus or
  iommu_buses[] change is needed. The devices are created before the
  accel device is registered and destroyed after it is unplugged.

* Session isolation: each session (accel file or legacy file) gets one
  context bank to itself on its first allocation or import. If none is
  free, the operation fails with -EBUSY. A buffer that resolves to
  another session's context bank, such as a PRIME export imported back
  on the same device, is rejected.

* Memory: buffers are DMA-coherent GEM objects allocated from the
  session's context bank. Imported DMA-BUFs are mapped into the same
  context bank and must be contiguous in its IOVA space, because the
  DSP firmware takes a single base address per buffer. The DSP manages
  its own virtual address space, so drm_gpuvm is not used.

* Per-SoC data: the stream-ID position in DSP addresses, the DMA
  address width and poll-mode support come from OF match data on the
  two existing compatibles, "qcom,kaanapali-fastrpc" and
  "qcom,fastrpc".

* Invocations: context IDs are allocated from an xarray and carry a
  sequence number. Waits are interruptible; an abandoned invocation
  stays alive until the DSP answers or the channel goes away.

* Privilege: the CAP_SYS_ADMIN check sits in the shared session code,
  so it applies equally to both interfaces.

* Audio PD remote heap: the reserved-memory region and "qcom,vmids" are
  parsed at probe, and the region is assigned to the DSP VMs with
  qcom_scm_assign_mem(). It is handed to the DSP only on the first
  successful Audio PD attach; later attaches, for example after a
  daemon restart, reuse it. It is returned to HLOS when the channel
  goes away.

* Capabilities: DSP capability attributes are fetched once per device
  through the DSP utilities handle and cached. If the DSP does not
  implement the API, the query fails with -EOPNOTSUPP.

* Poll mode: a session can opt in to polling a completion word for
  invocations of dynamically loaded modules in a user PD. If the DSP
  has not answered within 10 ms, the driver falls back to waiting for
  the RPMsg response.

Changes in v4
=============

v3 was mistakenly posted as "v2"; this posting is numbered v4 to keep
the numbering consistent (Krzysztof).

Architecture
- Drop the qda-compute-cb custom bus and the iommu_buses[] patch.
  Context-bank devices are now plain platform devices created from the
  existing DT child nodes (Jason).
- Add in-kernel compatibility for the legacy /dev/fastrpc-* UABI as a
  separate module on the auxiliary bus, covering every legacy ioctl
  (Bjorn, Dmitry, Rob, Krzysztof).
- Bind the existing compatibles instead of proposing a new one, and
  make QCOM_FASTRPC and DRM_ACCEL_QDA mutually exclusive (Krzysztof,
  Bjorn).
- Explain the motivation, benefits, compatibility model and fastrpc.c
  removal plan in the cover letter (Bjorn, Krzysztof).

Memory and sessions
- Replace PID-based context-bank assignment with per-session
  assignment. Context banks are no longer shared (Christian, Rob,
  Dmitry).
- Size the context-bank registry from the DT count, and drop unused
  fields, NULL checks and stored counters (Dmitry).
- Reject buffers that resolve to another session's context bank, and
  check offset and length against the buffer size.
- Document the import contiguity requirement and the reason for it
  (Dmitry).

UAPI
- Buffer arguments are (handle, offset, length) only; the inline and
  DMA-BUF fd argument forms are gone (Dmitry).
- Use QDA_ prefixes throughout and document the scalars (sc) layout
  (Dmitry).
- DRM_IOCTL_QDA_QUERY rejects unknown query types; drop unneeded
  padding (Dmitry).
- Add DRM_IOCTL_QDA_REMOTE_MMAP and DRM_IOCTL_QDA_REMOTE_MUNMAP, with
  whole-buffer and attribute-based requests.
- Add DRM_IOCTL_QDA_REMOTE_SESSION_ATTACH for the Root, Sensors and
  Audio PDs, including the Audio PD remote heap (open item in v3).
- Add QDA_QUERY_DSP_CAPABILITIES to DRM_IOCTL_QDA_QUERY rather than a
  separate ioctl.
- Add DRM_IOCTL_QDA_SET_OPTION with QDA_SET_OPTION_POLL_MODE.
- Require CAP_SYS_ADMIN for signed process creation and PD attach
  (open item in v3).

Protocol
- Handle context-ID wraparound and stale responses with a sequence
  number (Dmitry).
- Make the response wait interruptible, and keep the invocation alive
  until the DSP is done with its buffers.
- Fail pending invocations cleanly when the DSP restarts.

Process and style
- Rewrite commit messages to explain why each change is needed rather
  than what it contains (Dmitry).
- Put the MAINTAINERS entry in the first patch and add each F: line
  together with the files it covers (Krzysztof).
- Use guard()/scoped_guard() for locking (Markus).
- Use the DRM driver debug category for debug messages.
- Add the missing newline at the end of drivers/accel/Makefile
  (Krzysztof).
- Reorganise the series so each patch adds one feature end to end, with
  the shim support for a feature following its accel UAPI patch.

Testing
=======

Tested on <PLATFORMS> with fastrpc_test from the open-source FastRPC
user-space library, built with the open-source QAIC IDL compiler. The
test was run both through the accel UAPI and, unmodified, through
qda_fastrpc_shim:

  fastrpc_test -d 3 -U 1 -t linux -a v68

User space
==========

- FastRPC library: https://github.com/qualcomm/fastrpc
  (accel support: https://github.com/qualcomm/fastrpc/tree/accel/staging)
- QAIC compiler:   https://github.com/qualcomm/QAIC

Patch organisation
==================

01      Documentation and MAINTAINERS
02      Driver skeleton and RPMsg binding; QCOM_FASTRPC depends on !QDA
03-04   Context-bank devices and per-session assignment
05      UAPI header and DSP name query
06-07   GEM buffer allocation and DMA-BUF import
08-09   Legacy ops table, auxiliary device and shim skeleton
10-14   Invocation: contexts, RPMsg send and receive, argument packing,
        invoke ioctl, invoke through the shim
15-16   DSP process creation and release, and through the shim
17-19   Remote mmap and munmap, and map/unmap through the shim
20-22   Root/Sensors PD attach, Audio PD attach with remote heap, and
        attach through the shim
23-24   DSP capability query, and through the shim
25      Poll mode for invocation completion (accel UAPI and shim)

Parts of this patch were written with the help of an AI coding assistant
(Claude, claude-sonnet-5) and reviewed by the author.

Previous versions
=================

v3 (posted as "v2"): https://lore.kernel.org/all/20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com/
v2 (posted as "v1"): https://lore.kernel.org/all/20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com/
v1 (RFC):            https://lore.kernel.org/dri-devel/20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com/

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
Ekansh Gupta (25):
      accel/qda: Add QDA driver documentation
      accel/qda: Add initial QDA DRM accelerator driver
      accel/qda: Add compute context bank devices
      accel/qda: Assign a context bank to each session
      accel/qda: Add UAPI header and DSP query ioctl
      accel/qda: Add buffer allocation for the DSP
      accel/qda: Add DMA-BUF import
      accel/qda: Add legacy ops base and auxiliary device
      accel/qda: Add legacy FastRPC shim skeleton
      accel/qda: Add FastRPC invocation contexts
      accel/qda: Add RPMsg send and response dispatch
      accel/qda: Add invocation argument validation and packing
      accel/qda: Add the invocation ioctl and teardown on unplug
      accel/qda: Add invocation through the legacy FastRPC shim
      accel/qda: Add DSP process creation and release
      accel/qda: Add DSP process creation and release to the legacy shim
      accel/qda: Add remote memory mapping to the DSP address space
      accel/qda: Add remote memory unmapping from the DSP address space
      accel/qda: Add remote memory map and unmap to the legacy shim
      accel/qda: Add remote attach to root and sensors protection domains
      accel/qda: Add Audio protection domain attach and its remote heap
      accel/qda: Add remote session attach to the legacy shim
      accel/qda: Add DSP capability query
      accel/qda: Add legacy shim support for DSP capability query
      accel/qda: Add poll mode for invocation completion

 Documentation/accel/index.rst          |    1 +
 Documentation/accel/qda/index.rst      |   13 +
 Documentation/accel/qda/qda.rst        |  222 +++++
 MAINTAINERS                            |   11 +
 drivers/accel/Kconfig                  |    1 +
 drivers/accel/Makefile                 |    3 +-
 drivers/accel/qda/Kconfig              |   45 +
 drivers/accel/qda/Makefile             |   21 +
 drivers/accel/qda/qda_cb.c             |  129 +++
 drivers/accel/qda/qda_cb.h             |   29 +
 drivers/accel/qda/qda_drv.c            |  229 ++++++
 drivers/accel/qda/qda_drv.h            |  187 +++++
 drivers/accel/qda/qda_fastrpc.c        | 1417 ++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h        |  452 ++++++++++
 drivers/accel/qda/qda_fastrpc_shim.c   |  745 +++++++++++++++++
 drivers/accel/qda/qda_gem.c            |  146 ++++
 drivers/accel/qda/qda_gem.h            |   53 ++
 drivers/accel/qda/qda_ioctl.c          |  460 +++++++++++
 drivers/accel/qda/qda_ioctl.h          |   33 +
 drivers/accel/qda/qda_legacy_ops.c     |  212 +++++
 drivers/accel/qda/qda_legacy_ops.h     |   68 ++
 drivers/accel/qda/qda_memory_dma.c     |   85 ++
 drivers/accel/qda/qda_memory_dma.h     |   22 +
 drivers/accel/qda/qda_memory_manager.c |  213 +++++
 drivers/accel/qda/qda_memory_manager.h |   77 ++
 drivers/accel/qda/qda_prime.c          |  217 +++++
 drivers/accel/qda/qda_prime.h          |   29 +
 drivers/accel/qda/qda_rpmsg.c          |  322 ++++++++
 drivers/accel/qda/qda_rpmsg.h          |   26 +
 drivers/accel/qda/qda_soc.c            |   66 ++
 drivers/accel/qda/qda_soc.h            |   61 ++
 drivers/misc/Kconfig                   |    1 +
 include/uapi/drm/qda_accel.h           |  282 +++++++
 33 files changed, 5877 insertions(+), 1 deletion(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261102-v4-e8feb321263f

Best regards,
-- 
Ekansh Gupta <ekangupt@qti.qualcomm.com>

