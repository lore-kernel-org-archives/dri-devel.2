Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B415C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C6E10EC6B;
	Wed, 29 Jul 2026 14:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjYJjsfh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpB70HSI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EEE10EC5C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:05:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TD8IVh2145063
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dtdy+XMyJko6rbke1I+HYXXk
 E83TfRSaA1yEDFKgiGU=; b=YjYJjsfhT6NJP/PNCN02QupJhX46Ya30fQF/PoUj
 LET0fwlDTdhAuPeStwMMBKIOcrrQa1oaNjAH5b11a8Y4nFDbAzgroyHRoN1Lx54y
 mM/giatmvOdw9N1ByIGEICPlKL/Pn8he0P2ObHEIkXsfLRoAK6QBLTRBSXPVCNkJ
 K42Q1DcxRKwJUnLdYKOAJAgapp4tdtepZ+Ra3Yfn0Zt9D9/gmeuZlrFWpsUXglVs
 +mMc/kMTfE12Sf00VYi/oX3EVf8L8LWUl7tHHq8vtQYM93URIpUudMxvndo+t42i
 qymuK29z+D0q7/QjyATpuJWuEWhYAWPtJxo5icNlQXEZLQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3gghnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:05:19 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c2cd8c6b09so1022259e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785333919; x=1785938719;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dtdy+XMyJko6rbke1I+HYXXkE83TfRSaA1yEDFKgiGU=;
 b=bpB70HSI3/XuVeMXG0uXDa5JI0KqfMGHeMm99bX8WsBgOUtEYsVnwODiR3pJbN8BF6
 YIOTbzFeDgaToNCgdVvRYgi6IrziWV9x8wyQAjz15P8rXdRzgQ85xYNScFfsLyZEgofy
 QeAzXIRdwk4JZM1hvCr5MqrVYDFRwGZbRYBtBSuKxPaRTVc3uGoe64fD7sK/Ee5W4Kwc
 +KAoEJ/Y6Z121aSqaxytBqlygP/cmMndAZegpKm/mR108gE40vSkKNzKlQSTZrC/cgDS
 BUCYnsUX0rYxfXpBKgH4KhvIEFF/kP4C6zy06TUrVbQuKpSTZNSnS9Lvw6/R0K+j63Wh
 1uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333919; x=1785938719;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dtdy+XMyJko6rbke1I+HYXXkE83TfRSaA1yEDFKgiGU=;
 b=SotSezI1pMcchr5pXp6oLvcqcIYx2zvsJjMmnZQpD4yBqY64ucISzzp7dqSHw3mJdE
 tHGWl3CpvKQvJBGICirri9BrOdl7jhQuliHi/2+lNChl8+LxWAIsxiLsllc7pZAKV+Ie
 oOM6cATS5T59QYfi/Ykg4IxxgmHdT8NEVS2fxAQc0ajQEXlxCguE1eTCIQ0oh2xn6Xw2
 CElclSd8U2v7ZrneUGEjgcmq1gdNyYJN5VVybnLBvgzP1L44ivvZNAeuNxOi5JPZgAbi
 9ICf0rORDcEVfcH3TpvfVYn2AKRodGTeJXrQxpdwZadUvlsvcgW2lxeWBHcmmhNpI5wp
 G7Gw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCuvzl75n6RYa2RUA0+xRNL4VjtmVQX/aln+Q/eQ2lEHRBjl0/EnCnUfsUIY36iH6W7Lf8RCJPfiQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjF5RZeLR1OUnhng8iwX+XNTaXhDiPt8ZXrP7gRhRBQHH6pJuo
 avczLDcsLnviYWaxKTEd5Ug8C/V8X2XiDPOCRQhhXJw0NJDOwpZMQSt7RH1Ig8A+3udIfwIFLYs
 URJiYqw5Qw10f/zwxLVXy2EKo9C5vvzUbWFy5T3N/1/rvwgVRFo+xJCz2GZYan3d6d3QVb3c=
X-Gm-Gg: AR+sD10Mw82rJk/tLCP3KPu+9dJNjLOyal2cF4Wne/gEhzRfpO6I0+0WVe89970lidi
 XY6eDlUmp+5e4stbTu+kkwCGvytZ+DcAkCPngcxZVs7/RqrBHhmcQu6SUR6dg9LKlwAJOCnP7PJ
 AoZCBdxpQpPSIpZChGjwNfV1kkodeprbpG7B+tWTddO5h8KFboltcBjucBDACY91rsbspRji5Ta
 Pp0InAYd1jhpmsXixcjh4Rb+3V6Yl97Iqqm2H1TPPV5/gFAD6A6KcqJdolBvqLI+K+PSaXpDD+5
 C5iAM6fIT6x7TQMVgp0g6yF53I/dpDoFLxZSgCctHnwJ9iVZ5UDO0Dz63N9md5NrG3OfqrzJe8I
 wFLQguytgf6sKhYIjqee74JEQKz5xlTsHQHotfJKGzeUrMmOXPF4EVrTS+ZS7WwMiwPEvXHFrQ0
 +xOriA9FvRimO+5Q==
X-Received: by 2002:a05:6122:168b:b0:5c1:47db:cfcb with SMTP id
 71dfb90a1353d-5c33f94e88cmr3208368e0c.4.1785333919010; 
 Wed, 29 Jul 2026 07:05:19 -0700 (PDT)
X-Received: by 2002:a05:6122:168b:b0:5c1:47db:cfcb with SMTP id
 71dfb90a1353d-5c33f94e88cmr3208312e0c.4.1785333918363; 
 Wed, 29 Jul 2026 07:05:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f5d68b24fsm4265361fa.22.2026.07.29.07.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:05:17 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:05:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: mohit.dsor@oss.qualcomm.com, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org
Subject: Re: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <5xpvwwovgwuxltjqjnlchamwcvppdc4376fcujeqovm7fr3uhw@6r55ztlq47ob>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
 <20260728112614.BF6721F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728112614.BF6721F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNSBTYWx0ZWRfX35f1FqvZIjUi
 B62cJ3oTOtA2xCTXerHs92l/Hv4hdgIovNXcnmVKkI5ohTfnIFpwq+FK4WdQCgbg/ADMMEpBOlW
 z06gBk7rfavT06aCDL6uhiykykrZsNxJ0qXpMUpg3MRy5I01aNLp0lYQBSHyRwJ6J8icoNzz9EH
 9wpe2Noz+R44mDyJncgRP4vUkfb3SnUmbnfGVQ0S4+Zw8sjA2/KlSLG2Tg6a6nDe+vCGpLvq3Y1
 yIdv9H2g+vCJF99A5CcJxQ0dl6+Ld8ysXasdPUtbNl+F1r5HVSL7+XMyDXFrYCRbKMSJPKWmyKV
 ISSrqSrHdYQjf5HGHfWojb1L1QcXe+36xivzkKQGYYmRr/4qIPPxqqKkbMUp7uDTk/OjX92rYhV
 NM+2x7j0h+gGMwhvgD2e4ZNJV6mX5+wxqDwccjZNQnAhHBBTBCIU0QzpRm/VlO9wdufMPInyx08
 RBjBOO2R/+/W4CAEeDQ==
X-Proofpoint-ORIG-GUID: A36PJwzpnvUa5qpeze0kTROR4SNB0CGy
X-Authority-Analysis: v=2.4 cv=EOw2FVZC c=1 sm=1 tr=0 ts=6a6a089f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=CTjjQwyGzVbXpAY5hREA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: A36PJwzpnvUa5qpeze0kTROR4SNB0CGy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNSBTYWx0ZWRfX+kw31t7CDuZR
 FpslVsbcfU8o5JIi+WuMVwz1XekJyJVeMJSWgXKA22V5EHUcZFJqo32OiI7r+rxW6sInbOCGUhI
 oCbCOKSVkRdE4UCViioxTT/xI9dYczQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290115
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

On Tue, Jul 28, 2026 at 11:26:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 12 potential issue(s) to consider:
> - [Critical] Recursive locking deadlock in `lt9611c_hdmi_audio_prepare`.
> - [High] The IRQ is enabled before the hardware reset is completed during resume.
> - [High] Premature manual teardown in remove() conflicts with devm_* APIs, leading to UAF and timeouts.
> - [High] The IRQ handler incorrectly clears unhandled interrupts by writing an inverted bitmask.
> - [High] Early registration of the DRM bridge exposes it before resource initialization is complete, risking use-after-free on probe failure.
> - [Medium] The return value of devm_drm_bridge_add() is ignored.
> - [Medium] Selecting REGMAP_I2C without a dependency on I2C causes a Kconfig warning and build failure.
> - [Medium] request_firmware() is called while holding the ocm_lock mutex.
> - [Medium] Missing `regmap_read()` error handling causes uninitialized memory usage and broken firmware upgrade logic.
> - [Medium] Incomplete error recovery in suspend callback leaves the device in a permanently broken state.
> - [Medium] Synchronous firmware request during probe may permanently fail if the root filesystem is not yet mounted.
> - [Low] Firmware version is not updated in the driver state after a successful sysfs upgrade.
> --

Please respond to Sashiko findings.


-- 
With best wishes
Dmitry
