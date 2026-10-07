Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF05CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E569F10F4C8;
	Wed,  7 Oct 2026 08:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoqdohNx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2MCX4AF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1251010F4C8
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:45:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jupC2312998
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ppfdFba9NOF
 0mFMXk2YDZQ9fH8GXGF50XvGHTUha684=; b=UoqdohNxKpwMCxxz8E4VqEH0tU+
 J6jxU/ZmnCo5uNc0Lg8L3IeklXORD5N7Up+TtUjz1B/qaaGgIICz8rZ32OUQAG2n
 LlrO69yKPhTG0WPsxTJbRJDgrahH8QBpFbR0Mk4VjByHdRpc3qKrNqOATaj5oC1A
 k0Isy3JFj2IsCY47fLUw0D9dfebW6NupYlCuEhwpAAjw3ZLdwAzPKlV0gMIvAHKV
 5NDt1WUwWorEcTXVciZLvA4W8jXSbbJVuF/sdEycKE9sjfLyxqP2har/XNxBHI6I
 SD4dg6XUgNuU9KT/qlWLcUjJk6kzWF/7QQTgwqDZWFDyg65zpp/3x6MKZzw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53askkj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:44:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so4546305a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791362699; x=1791967499;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ppfdFba9NOF0mFMXk2YDZQ9fH8GXGF50XvGHTUha684=;
 b=i2MCX4AFueqqqDSytNHPmR6nhIASrvs1oxj1+h0YZxFrtr9gwwp3WFFMFLvhUVImQk
 +PWIuuu7d5EUBDcEt3b6EfYh2DgAj+FKPaGoWr/PY/13HAU39NxTiER/b2KP+CG+8mvW
 glhoBDdRvFL1fi8mnJFklN0lvWmfQ1Dhbyy42FQLtYtMkiR1qxsTWaz1fmSNfCDtsLzs
 9e5lwyZkoF3+m6zE9oiHGxcjIBtMa/c0UeplxPtD+9Jeumsj+YSp1fju9Ovc/25KXGDI
 cxOboZJXtLzs5BKqFd6MCo21JZ1kMGsCJaRkpyL7BZn+3F5IJGsplVphijCNXFdDjiTK
 vwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791362699; x=1791967499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ppfdFba9NOF0mFMXk2YDZQ9fH8GXGF50XvGHTUha684=;
 b=aa1IFizNS8N09r07SdCWj2Abp9H7PtF7N8IsYkq+O6uU7Jrjfp6lGD7SibVCofJkXk
 Ixb3KFeD97I8Nkt/RsigRbopu2UbOteXKiKjvqSBBonrxOWsQz/BcVVwCLJTVAFY8oht
 RsnEQFzstcfeCRelGlEyAcRZyErf3EivWf4Hh94k/uhTfOOW6pZdp32mzQ1sV6MLhvgH
 b7zWhWhoYew97/LcQlHFTwxjSs4M8pYecN5tuW28n6minS3xP46OB6XdP7TisXuiGorO
 pQCsA7HfAcj/OSbO7LkV9ZpIl5AQpnOiY6lZ026Pyyjp3IwC9rVEe6OsbUSxegZvd0XK
 uOwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4H+6QcYqx8iFzdZ53w2mK+IEmdjbEIWpBKPfWTUd9pbMlczO77PCYDj+kWYqu8lcVnIXYAjbpPLc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEgs14kW7tzQTdDJ3c3Gh3ZnUjxTQe8H5l0OMPD+BKQJ3FsB3/
 6R7oB+vc8T9MjBz/Ckj/DPrHLemwIzS2yLx/fWxlcwe4fAOX3Yh+axyJb//2tKJ3yCrsuMzgXd1
 ooZCd5OeVb8mPgO77tGyYumZsVjgKw3SW52hX+GQzwzr7hR4AhlHEGWhDYpa0JDuHs0mx+uE=
X-Gm-Gg: AYBFou0u4CL3b72u3QnGzBWxLyPicdV3zziydvePtrdJfa9DFSAGuSgGhpbMNVFBlng
 sMq+fbhjMzF0hgc0gQOjVvORsAvJwi8lkC79AQ6jZaziO+cKP5J0AGtAHmvF7ahVDc69rLAsHrk
 8mvC4QO2hEYsyI8L4iaY0shv9V+V10Cz0Gm1CtIv71kng/9b41nnlAHW9s0ZFkgvC4oHHrFp0LY
 k0q08dIWWCjyTJOYGpWkvoqWvYrXGAgURSEdz9t6R7o8OLnFQvSxnI/piv2xfODGkRYTHJEtA3O
 OLlzeN7lv6K3Gz5dTT1ls/YYwwqZknuY4JdfCTVQ4KwD0JXYF47OZLSljYIx9f1TmZZdu8osgS/
 jhhtl2h5dZzzw2CYktVLVdG1Qo+/8bPwJOM1DILG+vDS/HX+f8MLF/IUbwwmqsxSGCHypju0=
X-Received: by 2002:a05:6a20:7343:b0:3dd:57bf:7242 with SMTP id
 adf61e73a8af0-3e133dac803mr1178967637.8.1791362698828; 
 Wed, 07 Oct 2026 01:44:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3dd:57bf:7242 with SMTP id
 adf61e73a8af0-3e133dac803mr1178958637.8.1791362698381; 
 Wed, 07 Oct 2026 01:44:58 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8b0616esm1075091a12.6.2026.10.07.01.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:44:58 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v1 1/3] misc: fastrpc: initialise channel refcount before
 exposing the misc device
Date: Wed,  7 Oct 2026 16:44:45 +0800
Message-Id: <20261007084447.922-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CjhDO4F7vEHTcDhcAhhsO5ExL59p2QqD
X-Proofpoint-GUID: CjhDO4F7vEHTcDhcAhhsO5ExL59p2QqD
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac6068b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=zKkcRt30B2kSqeCsNmQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX36EbCmECCsLk
 CavYlH/VY7HilmU2+FoGffY9Bi4fhRrRwmpJw/Ex7c+WLbClk+3Bz+3fe8qaGvl0Ask6CJkQsDy
 tRxYD9zzEAXKXhzX5rfvnCsdmG+wfBJWJqh7Ap08d2i9pmiB6ZaCX8nu30Lk16c0giV+ZVGjEY+
 aQQzD/Jx6X3qVAChv0PnTijWj/E15pNlTIsyClS0EAMY0qECEj5goFeAaqtl6sI00aebsNC54bJ
 ToRUMTcXuSlA4XOfZcjMyhKgudytbaj3d0wQ38rGbgXXr8G/VOsyix6Rh0tSh6JfKYG6P6zhi0j
 SykwPRvWItkklgJgaBq/vDi/mLrQhxA+tS2JbG8gV55JReKbV/LdunTTEGuIesUh9JsT9xOIjED
 tA7dgL0huXb58IOBYU2BjQ4iyCoBJcJBFfsx88zRgknkK96pJsaPkP26MOiqF3DmsI8CcKiygEF
 JAzCf/lEMBQ++K1lvOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfXxiqXGA456rsk
 BS0UgJlk5wA7KrHV3hSGr6427gTBWQx9fh+K5WGNlzgdOL83j2WmSCme8wkiZcgWilNEkfY+nPK
 hzHWirykl4fX0OalW/le6M2NrIwPqB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
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

fastrpc_device_register() calls misc_register(), which immediately makes
/dev/fastrpc-<domain> visible to userspace. However, kref_init() on the
channel context refcount only runs after the whole domain switch()
completes, several statements later.

Any process that opens the device in that window reaches
fastrpc_device_open() -> fastrpc_channel_ctx_get() -> kref_get() on a
refcount that has never been initialised and is still zero, which
refcount_t correctly reports as a use-after-free:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 0 PID: 760 at lib/refcount.c:25 refcount_warn_saturate+0x120/0x144
  CPU: 0 UID: 0 PID: 760 Comm: adsprpcd
  Call trace:
    refcount_warn_saturate
    fastrpc_device_open [fastrpc]
    misc_open
    chrdev_open
    do_dentry_open
    vfs_open
    path_openat
    do_filp_open
    do_sys_openat2
    __arm64_sys_openat

This is easy to hit after a subsystem restart, when the DSP daemon
reopens the device as soon as it observes the PD coming back up, racing
with fastrpc_rpmsg_probe() on the rebind path.

Move kref_init() ahead of the device registration so the refcount is
always valid by the time the node is reachable from userspace.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..05b2e7e4ad3b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2599,6 +2599,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->poll_mode_supported = soc_data->poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
+	kref_init(&data->refcount);
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2626,7 +2627,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		goto err_free_data;
 	}
 
-	kref_init(&data->refcount);
 	atomic_set(&data->ctx_seq, 0);
 
 	rdev->dma_mask = &data->dma_mask;
-- 
2.43.0

