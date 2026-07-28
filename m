Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA8C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748F110E559;
	Tue, 28 Jul 2026 09:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGBJ0wLC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gb8RKxFX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB61410E559
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:46:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S829HZ3295030
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 su9taqsUBmJfG0aVGq0+6MjA0mnYfyHXK4TkmUilqdQ=; b=CGBJ0wLCP2LyyDQn
 xpeVSOKMEnPLG4Tc0N26aasAunVTmVlopOCUKZtsZghn1CLBBDz9CHs40uFU3wHV
 2UYWNe/VQwLnBp1eehmSKd6naEQ5L+k+q437jlrgjwu7IHAhhF3BuCXY1po/Er8X
 Ba50k6UX8P5U7W7MJW+OUugB1+AFxC/K3Lv+xVey958I9s6lUsuZj+05eVI+BC5o
 RFE/5GGV/BUvn30TTfP3FMHC5y7HeDNk7RtMbjiCamvA1V3GjO4HrDz6qlT1JHR1
 +PjjFsRqceO2KyvcabhP/b+pjTgvB9z1A8jcTCW/244iWlg87+qDPTGMZ6hytBTP
 q8ifCQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5kkvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:46:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so33607661cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231990; x=1785836790;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=su9taqsUBmJfG0aVGq0+6MjA0mnYfyHXK4TkmUilqdQ=;
 b=gb8RKxFXtW3eSDyOkJvOf61YlNg0RAElfNPlhncOsb+BuOphArnVbYTo1eSzjQBIiO
 myz9yTpX/CscZK1OKkJdRQqvmZfttOdSiPJ6jBilqWy4eUU/y84ygVluX3htNIE18gj8
 L2wcwkvQldPBpTNbBv/EA4MDv3w0KykHuAADWhH7k2Eug+SMggBW5KUpPC7LmFddAQOE
 3gMPhjEGY1bgNghhcwSa7Tm3o6Ti7rpc303ZJ4Q6hvHXexuyUIk7DelA30rUXbfIHYUw
 tq6AhmFfHiHP6x3ygOJKOg3txS8kaNfjmWGsTG6L5GhhGaIwZf9/zUgivpDZzcprmftw
 xaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231990; x=1785836790;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=su9taqsUBmJfG0aVGq0+6MjA0mnYfyHXK4TkmUilqdQ=;
 b=iPhpvb6W53kPOuyOH0MemeTPE5aFVMCJvzP91OKknlbxyecZABFsmu27PvtRyRH6z1
 evmwof08dMyemiFzhpEbPwueonRccgBHlqEplimmJ+fRE591yOaXKXlscEIsDTw9iyPA
 3KsEQ+php4i6OT5BML/8UQWMVtMwF3h9qWcOzWUtZ1XcWzYgOG609Yxn4/XIKlaqS8ss
 3dEVRt59UYx7o/0AWA3fECt9LzahT+k2UOEJkMfMVoMkGONddw3fXjaz566/QBxNmyjT
 yHYffKKAFDKGsHo3h2idn8/hGOrLIEjA4koxz96ElkQ4Oa/4PxRaHLjaFsvibYIqJLwS
 lLEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqc0IgaRnZ6AEiIkbTC5tUwLXGxrKGeAJ46mnrA2V85O/VeZzEwJDnyC0/ASGjjd7F0T/s+bPIX1eU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKyKnEMVxWPxfqF1xm/jxfF20LWY/dees4AfNKOTubzNVuduVc
 i252WxMfF4x7lMMvIs1u412QAkZ48RvLirbptQudbKkaD6c34tARoifWpNXJrqYIt50sBi4CWtg
 H8BHEEpyUSU9vCvaQ9R3qn5du445cV7TGAvRy22RDg0lrgRQ+R0ZTMpmWBw4WMxlRuiG0XeU=
X-Gm-Gg: AR+sD113rgh+cWZfJVCHUte7ZYdHci36u+E5QwzaZ7BnoC2HYfnoaBLb+YcY50kwr0S
 VXtGGSYpQpQMzsEjuTVpSqpcGRxskSoMpfM0tVcVh2IbvawP8xWHX2Qtf1mKCGaLeuZz54nX296
 2+YinnVAwTH5tB9nJBT4LvKaGFuOmb8a5fm9o+enA/x/8QFDkcGI7geo/OiL2I1Lgyt2jZFHvu/
 X7k8UNw/GUnDQP+vB5X8BiORMsB1gesa/RTwhIgQ6rfWmbiQIGHlFkA7EKwlIsjjj25AK/ElzPJ
 6v2IIZVuAVN/RqM+JsmBcCZEvoiXpwEMyY+J1ERys65FjYHzYFwZJbPHsQfbCWfoA3F9hapqUM3
 jtIlrQeSOtvkwlV+KOxlz+T615Bphwv8nh5+B/JaE54nTMSjFKjzWpyuPGur1O+1ItBVosLwgMI
 vThR1+cj8uhIjLPA==
X-Received: by 2002:ac8:7f51:0:b0:51c:ba4:d837 with SMTP id
 d75a77b69052e-529d6faf3eemr12028191cf.18.1785231990342; 
 Tue, 28 Jul 2026 02:46:30 -0700 (PDT)
X-Received: by 2002:ac8:7f51:0:b0:51c:ba4:d837 with SMTP id
 d75a77b69052e-529d6faf3eemr12027861cf.18.1785231989834; 
 Tue, 28 Jul 2026 02:46:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be1d8514sm1905891e87.42.2026.07.28.02.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:46:28 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:46:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com,
 qdchen@lontium.com, llzhang@lontium.com, hfxia@lontium.com
Subject: Re: [PATCH v17 0/2] Add Lontium LT7911EXC eDP to MIPI DSI bridge
Message-ID: <waw7uhdebjavtcdgcgvrdhos3vcervc3b6ggooj2zgkd6yq47v@kkzdagga6hoj>
References: <20260715015438.2770155-1-syyang@lontium.com>
 <tfkg2cjn4uznzy57rpkqwan26sduqzptnb7uwsucfboz37wz7k@rukuu36mozif>
 <CAFQXuNazLnXOr+qRug4De8W3U932aG9LVRVWgkHAE=ALSQ+ZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNazLnXOr+qRug4De8W3U932aG9LVRVWgkHAE=ALSQ+ZGA@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfX709qFnXOnwhS
 Uo0orkIht5IjtuKj4Mt+iEH4B1SduoGksidaeaM7JJxMJ6G3WYzD7PdpUnjiJ3BGYqCawIRa325
 yLWSEftqXXsitaCsDoijcgM0P9DWPQ4=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a687a77 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=xH18JlJX9u6X0IBL-vEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NCBTYWx0ZWRfXw5JQdihNapbx
 w+nJZeVWj2HXSLb+YZtu8fcDSpK4FSWZX3TByzwClWWaDKH9AhGf76aoBntS3KOG4Y//2nMSvsd
 xR21BLc/yVsbLhrZCDWiFpgC7IQXVRbdYLNIEKG4ck6xKE+QRhWjXZMQGpnq527OBXXXrJhRz0f
 SnFEFn4rusKR1Cl+FCcUMHgfFIgL9gWf5CIAPvSBNEkyVGxhuBN25iwZL0O66y1NbXx8R5k5G3q
 jCRDFeZg5lvpmkQ+z8rBwuAUBe/kxlP3MRl/SAprbM63nVZK5xFQ00V1Z2oQEDLjz+r9CvjLGn1
 8fRfZdw8aS5Pt2gFjVB6kZKNg7hEbeUxsOgnLyFyQsdJPnuAh3HSWx3PNAbBLK2Ii9ejUfCehuN
 ZUaqtfLjeWer1JAwM4zwXpljFBji6NT21rjB1zg19nW309g9Z/+Iai2XrgtkUvMnBT18Y6BuNq5
 RuG4zMT2hQ9ioRK6Pzg==
X-Proofpoint-ORIG-GUID: 5OQepJ_6X81oJWmMAA7eoHcMTw6wvecn
X-Proofpoint-GUID: 5OQepJ_6X81oJWmMAA7eoHcMTw6wvecn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280084
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

On Tue, Jul 28, 2026 at 09:56:11AM +0800, Sunyun Yang wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年7月28日周二 09:22写道：
> >
> > On Wed, Jul 15, 2026 at 09:54:36AM +0800, syyang@lontium.com wrote:
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > The LT7911EXC is an I2C-controlled bridge that receives eDP1.4
> > > and output mipi dsi. This series introduces:
> > >
> > > - A device tree binding YAML file describing the hardware
> > > - A new DRM bridge driver implementing the basic functionality
> > >
> > > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> > > ---
> > > Change in v17:
> > > - dt-binding:
> > > - drm/bridge:
> > >  1. [High] devm leak and list corruption on panel rebind                                                  [sashiko-bot]
> > >            False positive. The -EBUSY guard at the top of host_attach() (line 527) rejects re-attach
> > >            when output_bridge is already set, so neither devm_drm_of_get_bridge() nor drm_bridge_add()
> > >            is reached on panel rebind.
> >
> > This is not a changelog. Don't mix replies, with the changes in the
> > patches.
> >
> In the driver code, when I reply to the issues raised by the AI bot,
> the AI bot does not respond to me.
> In subsequent submissions, can I simply not reply to the AI bot's
> questions and only modify the issues that are useful for the driver?

AI is a _bot_. Talk to people. You should reply to the bot directly as
that's what the reviewers will see and consider.


-- 
With best wishes
Dmitry
