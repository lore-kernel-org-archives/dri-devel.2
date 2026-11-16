Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0500606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G0exRy1I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V2+kB4qB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D46E10F19E;
	Mon, 16 Nov 2026 13:27:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D78010F170
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0udo1482774
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=guvuApfm1WiVp6lOwwVdCi
 bXPFsCHhFXRI8JJuThGKE=; b=G0exRy1I7k8EfQ1IhV7Ysi77z/1Sf9YixnWMJf
 4TLFbn8IpNzsTkfKV4Au0zE1vsgh9wrzGlPgMpSaYvXLVlXvWms8PyqsQJ0JycMW
 jY83XBZdt7IB+lHvLB/VkYcWXtGnVC09xSkqGY6AJ5hUN0vPylBcacO7eS0ODSwU
 qbJ1pBf8c5rLQgJWIClRTiNr3QS43yWBdE4eTnHvOpd6z/VNSSlB2AmXarEXcrNk
 +KhSO8DDS3rTD5TqWU6h1gOxAKsbOPcXVv6+3Arab0mG9vmqATgWK0AzP5zfaIkS
 pjyY/okPECO2pqLnxNuhkXrSux0GWpZ+hoLVuxuzAlAPBEpw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgpm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:41 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-862bdb93612so1446785a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835661; x=1795440461;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=guvuApfm1WiVp6lOwwVdCibXPFsCHhFXRI8JJuThGKE=;
 b=V2+kB4qBixmWb03pP92yt5T2vR52XcW64+dzuvFrmzsSh9cCciJhSfovnUq1yfW3u7
 nXtvRy6LrGKzJwFL14PmeaYMcECQ8wmnY3F1vek5jo7JEdXTdv44yMmUZaNKDUID3/iu
 h5/54Ab7+griESqeT1AodvI+r6jKxWzdIXdNEZstvPsc0Tanbl1ZpDwzNBLEzDCdlhJA
 vOXrhmLUFYxcNiO3DkYIYmRVzfkXHlNJlciBKW+ArtNLq6QhOFPIk8Y7gVMq9Kz1JHeG
 uXDtKFp3ojQj3hWVkJ2LlJTwQGL3nUUjC1BqdVne5+CU/knSE08Juo1LRR9fl1uF5/yS
 eEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835661; x=1795440461;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=guvuApfm1WiVp6lOwwVdCibXPFsCHhFXRI8JJuThGKE=;
 b=m+qUroXDqAbteiLiIgdYYphskXCdH6wTnq8t6DyhCd/S65/jZX82AWq6vRJATEqGVC
 ZlTS4XcJKNnyhhiTpXK0zcnmxdDG7rfHxuUU4HIfjZ+ow1M4OKAXsiMEZUmLvRho5YbG
 4nFRGos7OgCI9aQtznH3JaeZ0OABxsC5xN60GZlJuzALziK4oRWBz+ECKeIHg7mfOwRj
 1Z8ZGgqMHxlxVxiw/Odd0IWPI8KIUGn7vUfPyLyaygPR3h/rRUoac8e8EiJOgH8M4E0i
 CuzemorIw4P36eVa2wBF0hKwLHkXKc+zE3/LMrnQzihjTUiI3RaWTOPXkthXWxp6Vvxx
 xoRA==
X-Forwarded-Encrypted: i=1;
 AL+hErFXpaSIapIwOKimA43b/OCeFP4rxiM7utyZDxMFgcuz7RPH2U3duEjZoCUXvrougjXCDAEUlhiWT4I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YZy3L9+fDplQLOrlEzvSybiX8K3AIaRa1GIa8oCDvLesNdh5Q
 7CZb0cdpanPqZE6rN7jQyCjgPhfYz06sY1i8RReXzJLtN47bYrqo3yW9E/g5O7TfKWjv2nEMvTN
 pOOxsZp8iKI1g3jD3DaAdLoBeeFOkXWxNqeHRjckVQN8XGfV+iaL2etzIIVriNhyWyOgY/Cs=
X-Gm-Gg: AYBFou1BX8DpuGp3oimf5s9c/9GSNFfptdLE89C/EoqA9Hw7ESBWuzQJhjgVBwNyYqg
 t8hf6Uqr07gNbP/dJKPds2DsiMc3hH39locuaSj4NWWMorZGNr4ri0nh9xjxxhNPrQxynHU2d8I
 6pxBUYsExILYcduXhymWGEJgoEhagd2PSr738XkymRp00tawtf1rbe3kNtGO1cmL1A43WKB6tHk
 IaPoQty8jdyvOaZZFBsDYbCmID9U41bTxsA846g1vzSfj3AxKWRYb5kA37xR6M60YI4XXFpLjr9
 P4LJFpzyBcanRWLvySil9WpdViObQL6z7ttVmTCMBdLd5KnYOKwQQla6/7040EHcZ8EamvOU4Uk
 ZAMccQJ6YwElBM49ssWPxyDSWNoBLA0Mila7kdK+OtEyNnb9DvJ9uZVXlMLhsoej/gqaHGRJpa0
 YnkU4mhAU=
X-Received: by 2002:a05:6830:2316:b0:862:b733:c7a1 with SMTP id
 46e09a7af769-862b733cc47mr3294280a34.14.1794835660775; 
 Mon, 16 Nov 2026 05:27:40 -0800 (PST)
X-Received: by 2002:a05:6830:2316:b0:862:b733:c7a1 with SMTP id
 46e09a7af769-862b733cc47mr3294260a34.14.1794835660295; 
 Mon, 16 Nov 2026 05:27:40 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628813346esm10012527a34.17.2026.11.16.05.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:39 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v3 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Date: Mon, 16 Nov 2026 18:57:29 +0530
Message-Id: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMEE+2oC/22Nyw6CMBBFf4V0bUkfoYAr/8O4aGEqTcRCBxoN4
 d8tuNAFm0nOndxzF4IQHCA5ZwsJEB06/0wgTxlpOv28A3VtYiKYUKwWklqNUxgaOgRvgFr3AqS
 SNbyumCkYKJKaQ4D9kYrX25cDjHOST7+wczj58N6XI9/SfYQzxg9HIqeMclmqtpamMhIuHjEfZ
 /1ofN/n6ZBNG8WfSohjlUgqrYy0yipRlPxAta7rB1+phLcdAQAA
X-Change-ID: 20260923-fastrpc-probe-fixes-30c1980b50e6
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 stable@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835655; l=2067;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=0hSbXEUHWhOnAJwHR1KYQ1+mIhj4JPQ+AgjXU0arhKo=;
 b=17vbNjqF4I1i1d38v3E4MmjngK7pIy50QiuIVJTmoCgg906g5vHwhP7znbye0X+F0LKim2bfn
 MUbmFojkzarC7ArQU4KIeGsPKsaDz7bY5knBTZSO1udOMn6nsPlASpo
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb04cd cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BKo7ZjnSzHxpABjNsfcA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 342FkAL2yx1L4F7pPUWZstP2XN6gdMMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX4YUPVqdnVWUg
 1Eee3U9pFKabxM3tlSqq66lsCw2cWgxh13PzzupXuHGfsnMfflcO0nz7O5+cganPHUKUMEGFQft
 E9J3khqXtjTzRmwib2sVc7eokDXcIUHSWyo/wJUGwpBqmUnOUEfr9c03+xDk32ZbljD7Hi7oT4s
 M3TYDxAZJWfR1T977bXT6rEE4akDkewYWRAaBCN+v8Jkg7nJi0BC1HZdvL8SdzIbTZ98tAzcbwJ
 uAXlXUrBAB1EVkc0o7AKnZVD6ktJn40X7ey818kyGZUSf1jimrzNq8giU9/ZpMqJq+Zasrn3Ckr
 dSTWrppguBIadt4vVmfHZXo9ODjv6OIgop/uOFC/MqAy7+o7f6EixYkiAJFVMuPnB/UTEEASVur
 MHDAjRU3D/fDa+M78/qzrWmFsF2q/suJBjAjTX2IblqP/frOcEaB6Xxi1UDjLTYGiwF/JdXONpQ
 m4nODHQU7QyPRPoJlUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX6x52w6hTtirS
 buuUqTeEPlS61Vo/OoWP4wcUrXSrRNDxlLn+wvUQTnEtN5iH5CfHVrM1VTyB8PGDrIbA6TUQhdn
 bq3DecT5WnTcB91X7kRuGzcip5lwYzA=
X-Proofpoint-GUID: 342FkAL2yx1L4F7pPUWZstP2XN6gdMMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160053
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two races in fastrpc_rpmsg_probe() that can be
triggered when userspace opens a fastrpc device node concurrently with
the rpmsg probe sequence.

fastrpc_device_register() calls misc_register() before the channel
context is fully initialised. A concurrent open() in that window hits
kref_get() on a zero refcount, and because of_platform_populate() has
not yet run, sesscount is 0. The error path then calls kref_put() on the
saturated refcount, which kfree()s the channel context. A subsequent
IRQ-path fastrpc_rpmsg_callback() dereferences the freed spinlock,
causing a kernel panic.

A NULL dereference in the fastrpc_device_open() error path when
cctx->rpdev is concurrently cleared by fastrpc_rpmsg_remove() is also
addressed.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v3:
- Drop the dependency on the dup-sessions series; use
  of_platform_populate()/of_platform_depopulate() directly in the init
  ordering patch
- Fix Fixes: tag of the init ordering patch to 965602eabb57
- Rebase onto next-20261113
- Collect Tested-by on the NULL rpdev patch (unchanged from v2)
- Link to v2: https://lore.kernel.org/r/20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com

Changes in v2:
- Add Cc: stable to both fixes
- Free cctx via fastrpc_channel_ctx_put() in the probe error path
- Clear rpdev and wake pending users there, as remove() does
- Move fastrpc_notify_users() above probe
- Link to v1: https://lore.kernel.org/r/20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com

---
Vinayak Katoch (2):
      misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      misc: fastrpc: fix init ordering race in rpmsg probe

 drivers/misc/fastrpc.c | 94 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 38 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

