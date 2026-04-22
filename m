Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632FFA1FDC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A305410EA5A;
	Wed, 22 Apr 2026 18:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiFftyjO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yl8mHSm6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B993110EA5A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:56:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfOLC2956213
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSDQlfPYquieSxnq9HkLMCvGbQcXT9UCSCqJ65VN4X8=; b=IiFftyjOoFAJ8qgJ
 cXVZWSxqrSworbHFUzH+8B3QxtAdLoF+OYWuT7n0RGVeAKlJaP42a9vsOLfJT+ip
 CbUzLOFY9C/k2A9Guyw/IY5fJJJUCfuSr6uTW6c7h9H+LVEu0LkBxhGwgWvelvzN
 Uwh1IHgIl3s2wuwxVOx2kU1BNohdnLnz7khz7RcysoaU1o5Cyn8e9+emjQFkeoaM
 nYenNmxoHx+5ywAIfKd5kWXWrmBuqoyUyQVHiHclqaeJitSgQ52dswNg0OJ+zfUm
 tN2X/MXI93CxsEoZ2/A5gv0z0/eIZPLKGtxc1OFuv2TBoYtg93DPuA96r97CaC6a
 C3naCA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q0ppr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:56:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so153982431cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776884185; x=1777488985;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iSDQlfPYquieSxnq9HkLMCvGbQcXT9UCSCqJ65VN4X8=;
 b=Yl8mHSm6odUcoa2MBGbMB/s09JUd+0rBd+25t0rH8W82maICMGvr5MKbcA6T+EMbOa
 1WKtjfTWkMxaZYww5bHb1LQPkRX7+6D3xCbDE9MwTr91UrKmueZuOq9FbU8GpF/+6zlE
 yk8MRx1FAwVfj9l9MHliie9TbyY7Pv3Ox5EAQ7ptGxQc+L9Dmwaf+yHYbFbpxwbHP7I+
 tn2wIfWiV9jVTo4Beeb+5Un2LiTAhRHdizM+MB8xfUtQCVYhghdu4gO5XOtxybzl0TU5
 rsAyuvhm7ubg849bVfhzzvGBq5wEibcwC8j0mjJkqy+Njvuhf/ruG14CU3BywiO4U6vx
 WlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776884185; x=1777488985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSDQlfPYquieSxnq9HkLMCvGbQcXT9UCSCqJ65VN4X8=;
 b=q+EghPYuByJrw23q2jZOaPDNQrOZLEHfSOZ9HSUPK9XQuiQHgVUs1ZO9Xjt6VcUOWr
 6oQg8PCWxXD/lHW9vw26DqTNXVkznfd6IenFYJmvESHq14k5OxJ1Td1FWz+8qTlPhjyQ
 Hx+LNZV86WBjmvcHPRgSPCIh2VkLcDHae4cLwHz5iLtJWri0Kl03T5shUhuFRw5TJ56e
 KFvYK/YxEfaWzbccbgY9AY++rSSxEmtUgsaM4RC+N2yMzcD9gbm2D3So0BgQ5tI7pvEf
 /MxVC7Q8FXyA7wJMKCAO4Cv+QwGzPwC6y4i1lU//Z1/Tes3g9gcJiAvdSHzwq+OocXAe
 ZnrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wbhR3sT+BPBZpUbr7IwZX72h8N8VZthFhnQlNkG79xlJsg4pv3uJxr6wbaQGQ3PhoY744WDkl+84=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhsiZUcxKNr4Br2ug0wJWitwWxZDNroe3wqw8h/vmLtdibhcnJ
 EgO5rsN15iEcuLlPWV0S6+HeuQigSrL+FbQKaUEO/z7WZTPy067CjgJzWGj+QE0WrPRjlUsGry9
 FFTB7IPFgsAkkbwp2ovggwhz7K5sbkMwaKRNvzxE6lTiYO9VG61Uzm1Bx5T4Lss2GKegkSNI=
X-Gm-Gg: AeBDiesPWLWXe2n+s0yTCbSo2Z6DVrbl/4j94n5egV9QvUTNfxQHOPLDvt0zN6oQcH1
 jUJyhtvhrjWsVTwEOm+5Y1HT7k9qwN3ZFdVQd3jiYD23L9+seEiFf/6Y/qnjFMcJ63/Krqf8/FJ
 nCDSKmPqNiD7+coG4BjZBpu5HosUEK3lJtDll91vOgQc3nmXHlrZSl8ps/9MAoL16ZTsET6DlOf
 H5qMEdIX0RucCMdua8f13bbB3yq+otDcd88yRKRNynOZFxnJZIQGCkkX2Sc6GPAlY3jkK1zbP7C
 GS7U0Q7cWEuk6LTrAzLSyAMgYD0kSr599gdUAafseWO7ycNO0mWGjXprJCfjq9OzZ2bry+SM98e
 z5QiVWAxHtmLu6NgsZQK7lXmFmozaftOO7O+U1l8Kd2n3BCD4f4rt9taVcAiKY8LzsRfoKLOJ5C
 8oyRnhxpu/MEo7EaSEF7McYE68cRZ9NkLSJI0jM7gT7BpigQ==
X-Received: by 2002:a05:622a:4116:b0:50b:48de:5448 with SMTP id
 d75a77b69052e-50e3681d04dmr335156411cf.6.1776884185019; 
 Wed, 22 Apr 2026 11:56:25 -0700 (PDT)
X-Received: by 2002:a05:622a:4116:b0:50b:48de:5448 with SMTP id
 d75a77b69052e-50e3681d04dmr335155911cf.6.1776884184545; 
 Wed, 22 Apr 2026 11:56:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc5e5sm4694979e87.27.2026.04.22.11.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:56:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:56:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v3 2/2] drm/bridge: This patch add new DRM bridge driver
 for LT9611C(EX/UXD) chip
Message-ID: <seno7shjhledyrunl5pib323zwgshtyhi455hzyspkhuvbps4m@qb4gwwakfww7>
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-3-syyang@lontium.com>
 <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
 <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
 <mvthlwcekj6i2h7bi5lns7ycictafjjyninvubp6adgaqxchkz@372c36cxon5t>
 <CAFQXuNZG-La0YpmHgMA-TZ2ayPDLfEvkbrSJZyW-jFCzXU-mLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZG-La0YpmHgMA-TZ2ayPDLfEvkbrSJZyW-jFCzXU-mLw@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e919d9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=lrge24zB_DpNgzo6FaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: 9dGeQI7p17J6hdTR7wYyxKltTzgWq4Cb
X-Proofpoint-ORIG-GUID: 9dGeQI7p17J6hdTR7wYyxKltTzgWq4Cb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MyBTYWx0ZWRfXylIhc4LSH1QX
 rMNTbELXTAx7AeYWmgt+3WHOQMsCt0ImxiV2aqAkN7caLnMBkTVxsTJRZYmpClEW6Yc4qTUjMck
 cpp8APnGGnXQbG3fkv1aLSdHmvgU7X9N/oNCeKz8BLh1vHHY5568PlpEPi/BLivnr7ji+6algrd
 8obiSwwnNpY72pR5pABs7bZrh4DVyHs7NsNoxnQAufGDF0crTyGCjvVDkJjjeDfhudsYkmUwfbQ
 n9702wToG4ENl1JXdudMDRmONJQJJh64W8iDvNvx8tDVCR5BIGvGpTX/YggG3olCzyAadDmKc77
 EzXvb1EZFL6FVWQEsBPL6X7N9U6wdPGMSUnzHyOS++OPxLoGTcMJMtuMIX3I0p2l9Z2mAF/kQbA
 0EVvz63iBrZ765B5+pA2O8L29fNWObwLf2rykTarskREjelw6Hj/vpJ4Jbgcj1kVJPtd4DJYA2k
 xaZ1t0AvseguoHUDtpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220183
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

On Wed, Apr 22, 2026 at 12:41:11PM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月21日周二 18:48写道：
> >
> > On Tue, Apr 21, 2026 at 03:37:52PM +0800, 杨孙运 wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 20:18写道：
> > > >
> > > > On Mon, Apr 20, 2026 at 02:16:44PM +0800, syyang@lontium.com wrote:
> > > > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > > > +
> > > > > +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> > > > > +                                   struct drm_connector *connector,
> > > > > +                                   struct hdmi_codec_daifmt *fmt,
> > > > > +                                   struct hdmi_codec_params *hparms)
> > > > > +{
> > > > > +     struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> > > > > +     u8 audio_cmd[6] = {0x57, 0x48, 0x36, 0x3a};
> > > > > +     u8 data[5];
> > > > > +     int ret;
> > > > > +
> > > > > +     /* Validate sample rate and width (LT9611C auto-detects but we still check) */
> > > >
> > > > What for? You don't trust ASoC / ALSA core that the rates would match
> > > > HDMI_RATES?
> > >
> > > Chip has limitations on sample_rate, sample_width, and fmt, and cannot
> > > support all formats.
> > > The validation here is to ensure that only the formats supported by
> > > the chip are used.
> >
> > Again, for sample rates, is it different from HDMI_RATES? If not, it is
> > useless protective coding.
> >
> 
> I checked the definition of HDMI_RATES and ended up doing a redundant
> validation.
> 
> #define HDMI_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |\
> SNDRV_PCM_RATE_192000)
> 
> However, if HDMI_RATES is extended in the future to include sample
> rate not supported by LT9611C, this driver would require corresponding
> updates.
> If this is not expected to happen, I can remove the redundant check.

Updating HDMI_RATES would cause enough issues for the existign drivers
which don't have this kind of a check.

> 
> > > >
> > > > > +     switch (hparms->sample_rate) {
> > > > > +     case 32000:
> > > > > +     case 44100:
> > > > > +     case 48000:
> > > > > +     case 88200:
> > > > > +     case 96000:
> > > > > +     case 176400:
> > > > > +     case 192000:
> > > > > +             break;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     switch (hparms->sample_width) {
> > > > > +     case 16:
> > > > > +     case 18:
> > > > > +     case 20:
> > > > > +     case 24:
> > > >
> > > > and no support for 32?
> > > >
> > > no support for 32
> >
> > Then check for that rather than listing all the widths. If you check the
> > hdmi-codec, you can't get 18-bit samples at all.
> >
> You are right, there is no 18-bit support.
> 
> same reason with sample rate.

Yep. Check for 32-bit, the rest is fine.

> 
> > > > > +MODULE_LICENSE("GPL v2");
> > > >
> > > >
> > > > I think, checkpatch.pl should have flagged this.
> > > >
> > > yes,  it is need use GPL?
> >
> > If it flagged the line, why didn't you fix it? What did checkpatch say?
> >
> Sorry, it is my mistake. i will fix.
> checkpatch say:
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
> ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> #1450: FILE: drivers/gpu/drm/bridge/lontium-lt9611c.c:1364:
> 

So... If there was a warning, why did you ignore it? Please don't,
unless you really know what you are doing.

> 
> > > I see that many of the latest code still use GPL v2.
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
