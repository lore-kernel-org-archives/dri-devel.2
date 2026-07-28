Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB18DC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF65710E495;
	Tue, 28 Jul 2026 10:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUG0hYoc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNYCAL29";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BC010E495
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:27:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82kEr2275973
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLZ5WSf9P35tXLsEc25HzV/wI2h837sZFl1AcAxf2gA=; b=YUG0hYoc1LFSM5AZ
 L/UFDaMDb3Tq1qzfxpGmtKiLfKNPOiva0SmtzAyPkf9b87d7N6mUngzZ0DCJvj55
 G2DyoKfly36fRrjRCa92hE6Bx93F+z+8qEJBmbOujVtEYhHJf8LDp3O52s9S1F0+
 l/RGibWNeCTXv7EmeU+dVCVk/t7OWSJqBFtEK+ltYcQ1yxxxODAkmdkT83vZUE4G
 02Z98EVC8Ig8QILCzRKbZ3QmaDZO2Ukpipyk63A7JaDchkMi2SZh80A3SNMmQnJg
 p29rvQ3oEcxdfeb0XHHpteA/Io/t9Jm/7qfpSfil9hXvdWy3muAefv+dkqzNLEhO
 V0e+LQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsuqk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:27:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8488ac68185so1701597b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234441; x=1785839241;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLZ5WSf9P35tXLsEc25HzV/wI2h837sZFl1AcAxf2gA=;
 b=YNYCAL29kuiwj2KHKhzqvi+ShmcJtKtfzMuah8YAq1it/IE12BLrQBud9SMqkDgn2i
 0f0gswaTaXABgCROs6nH71jl0WvaqMJYF1O13mqX0JI7GxlMbOWAoMiXc582p9qUmNHE
 ofcRoPUCSFR6yagKmjtqyjEJSOGyzUjq61Zpz6J4xX0IL3FbX6leIn9OhDs3Fvd9s+dU
 dcw/g2L9BCaxdpFbV2pj9mIKSfxgw6de9YCyJR6fSRfb2WHFRJc75PZn+KQWjOcQozvK
 ifXYxWM7GENzRgAA7jTJsOt7nUAAgxcbjukEJqaxjSNDbDaYgACW4zs0kfbn/r7ttQ/7
 WR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234441; x=1785839241;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KLZ5WSf9P35tXLsEc25HzV/wI2h837sZFl1AcAxf2gA=;
 b=kbgEuqjFh51ngrAj346rWNcJ69IQ1vOjDrHEOeqrfAp8fL21TlKXz9sHHrZjRqkiTd
 Z/fyN56l/ij4qoPHwuESFpFl8lKOkckvStplJZjLuZ5C2R54NTBcWrcOyg2kOj184ErJ
 W9SRr5L/wxbxmSJccnJdd/EeBUW/Pam0DbNG5XwW4wFFWBNnHtyCkwOPNkqULMMOht1O
 6TnMCgpjCE2upwDNFKBjQ3fDRlJmMTUw0wFCDLq8fe6uEWsn0dvhMIHEiW6EyP4X5zt0
 iEz7ixwU/nlaK7zPFMI6uRj+h7jDgV6dCeiIHf7rjH29ht8sWDZtUqzDvcE+0ifRO90n
 LMQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFMtTOr/3EqctqmIWzI0+mHKSeg//XaOdMWd4oc7mtNBxjcR7gLT1h+0myVPu/LrpyWKObXHqSPqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzyo4EqrqFu2f2U8iaDjyFSA62Q3+S2ETggPEXvLJzJrFi82YRG
 P0W3fpewfiPktYV1deJ0NgSdncP8y9pPBxi3RAbkSBesqiwjK8/YecvPPDaLp+phpAXcOFqZSWA
 vd/B8YPFBYc8/hVRRjHzELx7J7JGKK8620tCY3/A/wMggALNEV5B5+ssKxRbxC8Xd/PxxnDfSGD
 4WFv3naecq
X-Gm-Gg: AR+sD11OCa5TP1mkJD+VD9rfvRLdZftfCYMpTTn8rUGRkLCz7FB4qPPe/v90hDRmsZL
 FTXfpmu3VrphXwBByej7yHJWTOfyJYqb7IFSPHRCHPVC1cOIbDax8FZCgUsWiNa8tD7RYGF49fJ
 8/c8oWPQ86hR8+p7drHHF+MB6zWLC5L3YMpB9axYsESwrdQV3hdpgXLz8iwSrETxsEox10DtW92
 DuFEkRYLOU4izy90ev50WOVWFFaQEas397BQJBTnCj5v4diCMT4aIdiR/XRHM168leUey4HYd8Z
 RYN391XqZsloDWJTdpWKpwpMZv8X5wbzx/35lMW3TpgwY7/l/4rJjdvZu0dP1SAOYNQgLYmSgPz
 K0wqyRyPLG7cOJmpvh5OZXQF75bRbuwO4LyTSrwhR/ztBrbTTA/dvHQPex1s1qe7xGMTJdX0DEL
 Hwu0EB6eIial7m0w==
X-Received: by 2002:a05:6a00:10ca:b0:848:2a55:7110 with SMTP id
 d2e1a72fcca58-84e932ed557mr1733303b3a.36.1785234440950; 
 Tue, 28 Jul 2026 03:27:20 -0700 (PDT)
X-Received: by 2002:ac8:7d81:0:b0:528:2e9:c0e8 with SMTP id
 d75a77b69052e-529d7260239mr12216511cf.79.1785234005745; 
 Tue, 28 Jul 2026 03:20:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be0806d8sm1946188e87.22.2026.07.28.03.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:20:04 -0700 (PDT)
Date: Tue, 28 Jul 2026 13:20:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI
 DSI bridge
Message-ID: <kp6eg7dierl5iqkr26e3uflyshjxes4kxrzgcw45etqfzop7d2@os3chspox42p>
References: <20260715015438.2770155-1-syyang@lontium.com>
 <20260715015438.2770155-3-syyang@lontium.com>
 <20260715020616.B73771F000E9@smtp.kernel.org>
 <CAFQXuNZdwNxbAsnK7P4zs0eZnm4pN+6kKkO-aP6Q_higPEW-yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZdwNxbAsnK7P4zs0eZnm4pN+6kKkO-aP6Q_higPEW-yg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX6F4Qt1JwdPFb
 IKNOKo07lNgVnsRM7kMZk+IOrgHzlfYFobC08N1AHy/hrRhGWgiLVxpKke95wWWq6rtU/F0KdrB
 BrNvrqxC3CBr6cioLB+t6kIOW+0Ko2Cd1qwnpZjHGEb1SN/3H7ayVf1a5tIue0Nfeuda+WKoKYw
 GNqpZY1BFb5sM106ZIewFi4Tiqn1wBNy7vJ/IcH90b3APrwGqRd6+7UwV1XsofHX6sruvI5OJ6g
 KmDvoLs6E94j+J7vu5YdThjEGQLLjm5gNxWwiiTPvl3Ob7Op9yPGrh/EfA1wTff+hhcGw5aIwO9
 leqGCECC3zAiTZAkWwhVVfCCaBfhW2Q8JcLjhoTiRnj3xvn7sSqrbIJ/dtv9NTrnhVDSkpO2/zq
 yqolrmOad2buhwMnR40x584xxEPyC+Sf3Ai2MiiTQA60xl5umFAEnptkVTJBW3WCAULZcTA/7hq
 hrxMv+ZjoIoGowoQzUA==
X-Proofpoint-ORIG-GUID: 7AaOBiRmmbhzWBQGWyBev7RCHccH7HMl
X-Proofpoint-GUID: 7AaOBiRmmbhzWBQGWyBev7RCHccH7HMl
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a68840a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=tlYR4POETLUKK-67TRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX/qGvfO9d2DZs
 mEGvXFFTDdIHds4GdAt5NUPnLYfAUNqQ4VfFfP4BZypR7kpQzNjd1X17TPRNF+/0kGLbs3OIwpz
 m3lCF3Sg2Eg4swtqXQ2Lhgca4PRa9RI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280091
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

On Wed, Jul 15, 2026 at 03:42:55PM +0800, Sunyun Yang wrote:
> <sashiko-bot@kernel.org> 于2026年7月15日周三 10:06写道：
> >
> > Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> > - [High] Missing cleanup of `output_bridge` in `mipi_dsi_host_detach` prevents DSI device rebinds and causes use-after-free.
> 
> Intentional design, consistent with cdns-dsi-core.c cdns_dsi_detach()
> (lines 1082-1091) which does not clear output->dev. Clearing
> output_bridge would allow re-attach, causing devm_drm_of_get_bridge()
> to allocate new devres without freeing the previous one, resulting in
> a real memory leak. The DRM bridge framework does not support dynamic
> bridge chain reconfiguration. No use-after-free: the -EBUSY guard
> returns before dereferencing output_bridge, and bridge_attach is not
> called by the SoC encoder after drm_bridge_remove().

Luca is working on supporting (more) dynamic bridge chains. Don't make
his work harder. So far:


- Let the DSI sync be detached and then reattached. There might be
  reasons for that (e.g. big DSI panels which use two DSI hosts). Ignore
  devm_drm_of_get_bridge for now (though I thought Luca has provided a
  better API for that).

- Use next_bridge provided to you by the framework.

> 
> > - [High] Sysfs attribute `lt7911exc_firmware` is accessible before the driver has finished initialization in `probe`, leading to a kernel panic.
> 
> False positive. The driver core creates dev_groups sysfs attributes
> AFTER probe() returns successfully. In drivers/base/dd.c
> really_probe(), call_driver_probe() (line 706) executes before
> device_add_groups(dev, drv->dev_groups) (line 725). By the time the
> sysfs file is visible to userspace, all mutexes, workqueue, and regmap
> are fully initialized. There is no window where userspace can access
> the sysfs attribute before initialization completes.
> 
> > - [High] Asynchronous firmware upgrade worker accesses `bridge.dev` without holding a reference, causing a Use-After-Free if the DRM display controller unbinds.
> 
> This is a known DRM bridge framework limitation, not specific to this
> driver. drm_bridge_remove() does not clear bridge.dev, so all bridge
> drivers calling drm_kms_helper_hotplug_event() share this risk. A
> proper fix requires framework-level bridge-to-drm_device lifetime
> tracking. Triggering requires root sysfs access to start firmware
> upgrade while simultaneously unbinding the DRM master driver — an
> administrator operation outside normal usage.

I'd say, I don't have strong opinion here.

> 
> > - [Medium] Driver illegitimately mutates the state of a downstream bridge object by explicitly modifying `pre_enable_prev_first`.
> 
> Hardware constraint. The DSI output stream (register 0xe0b0) must be
> enabled after the panel is powered on. The override is safe because
> transfer() is a stub — panel DCS commands are silently discarded and
> panel initialization is handled entirely by the chip's internal
> firmware. The panel driver's prepare_prev_first preference is
> therefore irrelevant for this chip. The comment above the assignment
> documents this rationale.

Commented in the driver review.

> 
> > - [Low] The `lt7911exc->removed` flag is read without a lock or memory barrier in the firmware upgrade work, leading to a data race.
> 
> Valid.

Should be fixed.


-- 
With best wishes
Dmitry
