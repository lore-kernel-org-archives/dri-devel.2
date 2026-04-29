Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9AFFF885A
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 01:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C104F10EE1D;
	Wed, 29 Apr 2026 01:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UaYN3e1t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EHEMItMO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC82A10EE1D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:57:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T1Y2iY3705173
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4urT4VP+Xz6y27POMSX0r8FX
 LKE43oUrv36tFzO1cFQ=; b=UaYN3e1tz/BlSRGuiLMZgQCQBm7D/jlmTF5PuOEK
 CbXSaPNBlvaMscixaephMeAGZIKp1qa4l7EBI7Y1Ge4TCw559dKawe4TWJuBjMS0
 1veAsgDktw5zfx31BiEIZ/+UzH/ElWvFXMh66WSStb1MKrzcUUzwQL8Nea8oorOu
 ubZ8Ts8nhayImGm8bOfxzqAvh65MPGZDY4cnS6z/m5Z1N08mHw8U2BKu7lWBtczz
 XsmFU3P1pxAZfgGbsfIwa6Cu1Lqk1hpDg4tXIsIFXVpCCpSA2zBE3FPbgVN3aedQ
 qMzioi1d7/KWzqFjNxN3CLq1PX9f1Br6lVYeuBM3xeVj9A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxhb5nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:57:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35fbaada0caso11357543a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 18:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777427852; cv=none;
 d=google.com; s=arc-20240605;
 b=JRONuXQaav+Ijhb05Db6Wyw3ILJOOYwuQGsKVyl++xUbjlTzihXz7tpKBvP/A9YYFw
 6pb5DovnwBgzzrMCiIr5h/zbLtUxvjLc/hwkCyTMMQHtJrogR7zEZ6bsW5grBmjXrspG
 /kbcUzhpXcYbVJWa97NdpvchCZDzOe1PyJOPEIInY0fSROWZQ4ko3/1JXHj7yLb9jzQb
 HS7sNW31ch4qMVoqeTG1+P7/fP7qjoT0DTCyr15xNZdFVzGV8qJ4JgWh07DK19njz+ZH
 HoND2WO/zGxCWU5i1B/t02qgH07Y0lAnh+tG6SUPu4zq+9WeRpHy4Tlea1FL6el+gvu5
 6OlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4urT4VP+Xz6y27POMSX0r8FXLKE43oUrv36tFzO1cFQ=;
 fh=sjVMtpeKGyrJLA5lTRA7KCiFX9jRvY9iHhPdnm2ZBpA=;
 b=JcQY2r0AcWannP6Ffrrb/5emwhwTouawYEIH1hJrZw06kT2jUowPlxzlWiM3Xatpul
 5ZQodFwF7P99mYUUlWnFJXxUIy/WBSu4lz3JuHB7DgtBBoZSpJxS1XgCRAyEdlpZMNZF
 yoAJh/cr68CNA+w3a+hEdG71tkQo10J10Zws3mgXx+qrouDvFIYcKb6b25DUljL7DgAm
 sCg8zWU5ohSTexw0uWbArM1x6VUs3HL25qYtvGCM1RlhgrBAJhMK915FTm8lMdZUIcL8
 gJq93vkPyEGAghDg4IaKCPkPxxgzv4GsrL0QaHypv5QtTdFgpUzz6St8Jr3hBfxBs8gb
 OOyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777427852; x=1778032652;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4urT4VP+Xz6y27POMSX0r8FXLKE43oUrv36tFzO1cFQ=;
 b=EHEMItMOp5Dly2atzY+YTn5a3Ox6QqNXUIXiRYKANswlNQdLChCiXy3zIquA7bY7bJ
 xIGz9D/uQesnOlRXlpIglFjWRKE4/3xW1ukTC+J9Md1reyLcizpKowbFkNuBvPi85Cd8
 yn9lLPhOEvpgb4Hrzk0uYyhjSAA0lrccYwU90sEaGh21/RAgc2+m5twJPXZNAYpYOqKe
 IyYHZNpe02gXIMb0Hw8WWLSjwIBkve+vcWTgp1z1ikylb0BXvqvUkEPD8W1OzkSrT8Of
 L1OTh59bW4w7TG1MpkpZ3/yHcDrFPLvJhBXPR+qBi2GBzFQV2BJgqC2knS2JuAYqBCHY
 sdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777427852; x=1778032652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4urT4VP+Xz6y27POMSX0r8FXLKE43oUrv36tFzO1cFQ=;
 b=TfeLMyJQiSTC9RU0IkIrUDNGty4QqDwqCjcGAHegP0gGMKS6NdAoa/2yVp+2aI8xLk
 KEHSF5Ei3UyxUBmlO8SpgwJDZ09gCrFj3F2Dikpt6imXiT7P5JpA1kKbFSKSue75TPAF
 llcBdk5sl4PENx5wpVFg0nHcjb82O/Dxb0D/M0ZaGQnZSmcoJpaziOV+kJexrXS5uSmW
 nQeT6BganAG4N2S/+YZQ+eOV3KlomCnDbbLLLuLZGvEddAiQCo+P1jq3Xa4sNPhZUsV2
 T9LSa3xbu5PB34GZMz601x3NwOBGTb3bHbqC6W7bTLwKag1tESpnPScWbNo1LY5/rlEp
 R0Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ERSTKqtlCsHzq4xupGmCB1Ez37uP09rOP3slMcr0s3KEPqI0+egKacBKd4X9LuDNO7XJcYvokFnw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Pl8xxB9KoZxSZKgJGuO/wkspFz7Ti54rAhBnN1FmhnsnWOvZ
 n0oPnVh93n6QtcjrLZAuNqr8GJtHUSnKKJ1BRT9evn/95vXyj1S2NBupr1R7fh66/JaSrDvThSe
 b/cm1lzMJIX6BIXklx8BF0JOvWKXI8cLJKuDTS7THfXI9j5zoJj0KzPxlTpf2icntDxDOx8wD1q
 Afc+cT4vO9on91wUw0HQJLUVuzhcnHkr9sd9twmnMvbLMO/g==
X-Gm-Gg: AeBDieugfU6sR4whbmjrf+LTovzOXRDJlPv068sOnFqkfZ41g/oyq2inMilYJtSd7UD
 AOgArX64qoxdl1wVPDqBXcrHxCcXWJ48uYPfcg/0Kn/jH1enVOfg8FDY7C9XF4wsVwNwXyBklX5
 UYmD+R5hYSEwXiKVG0qDmKVA96RDarkd8idOc1h6wA5K3RRxaTovn1Gnpq27gMpjxIZQILmzfVd
 bdscG3b5NsdNi+W9n4OEUKThuQGRzZACYd3Vd9j/N4PiA0U
X-Received: by 2002:a17:90a:d00f:b0:364:6558:99be with SMTP id
 98e67ed59e1d1-364a0f54fd5mr1869808a91.22.1777427851576; 
 Tue, 28 Apr 2026 18:57:31 -0700 (PDT)
X-Received: by 2002:a17:90a:d00f:b0:364:6558:99be with SMTP id
 98e67ed59e1d1-364a0f54fd5mr1869773a91.22.1777427851045; Tue, 28 Apr 2026
 18:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-10-jonas@kwiboo.se>
 <go5i5iiwra426hydnvc5thhgtknv3fa7ti35q3et6frroxag2n@tfbfiyjmtzkk>
 <9b4a676e-cf8f-4708-b580-8140a2e7a805@kwiboo.se>
In-Reply-To: <9b4a676e-cf8f-4708-b580-8140a2e7a805@kwiboo.se>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 04:57:20 +0300
X-Gm-Features: AVHnY4IYQX_h8aB5YnKvkJJ7Oy4QIDyzxAhVuaSDWbswPbN5Is-XUGtjvSm4n90
Message-ID: <CAO9ioeVb3KMao_jKraAjXUXqOVC=2bLgRA-Q-5DPArFYrgFFwA@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAxNiBTYWx0ZWRfX0QFaaX6vDki5
 XcJRSM9q2i0f+gKODBnPchYfY2klxlZw1oMumirdPaRP0FlE6qvp6iCXmcx39qaQuk7pKYUpFUO
 00uUebmnJ91Wt+1SuEUmzGFn7JdIkjT3XxBpwgJm8gTTfuyantx8YHR4/LO73StFR0agPqq51pP
 5VIUcOS73lWI9ai5HEBV/s+OWgJwMwE1r4Ozb+5KdX+X5Y1g1xx0GooeeS2osxCD16smphfKU+z
 MPplKjQ61emKsnborkc8mrxHSHLfssWhwzUD3SV7ir0ATpTqRL8OV21MpI6PYQJUOMh/yh1sxCD
 PQR8nD6n1Xc52Uo4KdJwZF8LIs77w4vBXdi1BXjtaKFUMqNL/EKK+dgDVqZY7Pk7nIPYjNdLMUU
 5VyFs0FDlgQY3IV8u/CmvTWbxiAbCmrs6mVNJ4ZS2hZ6NpAhBVCqduZTPpci20wIlYViWyDCkdQ
 QGp/XY1kMelfgkOPGLA==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f1658c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=c8wtwwsRZL7ZEJ2JRekA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 1W7U4ClVVrbiwsX4qfZB4UTBCDm155rE
X-Proofpoint-GUID: 1W7U4ClVVrbiwsX4qfZB4UTBCDm155rE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290016
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

On Tue, 28 Apr 2026 at 22:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Dmitry,
>
> On 4/28/2026 2:38 PM, Dmitry Baryshkov wrote:
> > On Fri, Apr 03, 2026 at 06:52:55PM +0000, Jonas Karlman wrote:
> >> HDMI Specification Version 1.4b chapter 8.5 mentions:
> >>
> >>   An HDMI Sink shall not assert high voltage level on its Hot Plug
> >>   Detect pin when the E-EDID is not available for reading.
> >>
> >>   A Source may use a high voltage level Hot Plug Detect signal to
> >>   initiate the reading of E-EDID data.
> >>
> >>   An HDMI Sink shall indicate any change to the contents of the E-EDID
> >>   by driving a low voltage level pulse on the Hot Plug Detect pin. This
> >>   pulse shall be at least 100 msec.
> >>
> >> Use a work queue to debounce reacting on HPD events to better handle a
> >> HPD low voltage level pulse when a sink changes the EDID.
> >>
> >> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
> >> other drivers using same const, and testing using a Raspberry Pi Monitor
> >> seem to use a 200-300 msec pulse when going from standby to power on
> >> state.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> v3: New patch
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
> >>  1 file changed, 20 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> index f3f8144ae98e..4d079b689b3b 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -51,6 +51,8 @@
> >>
> >>  #define HDMI14_MAX_TMDSCLK  340000000
> >>
> >> +#define HOTPLUG_DEBOUNCE_MS 1100
> >> +
> >>  static const u16 csc_coeff_default[3][4] = {
> >>      { 0x2000, 0x0000, 0x0000, 0x0000 },
> >>      { 0x0000, 0x2000, 0x0000, 0x0000 },
> >> @@ -192,6 +194,7 @@ struct dw_hdmi {
> >>      hdmi_codec_plugged_cb plugged_cb;
> >>      struct device *codec_dev;
> >>      enum drm_connector_status last_connector_result;
> >> +    struct delayed_work hpd_work;
> >>  };
> >>
> >>  const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
> >> @@ -2528,6 +2531,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
> >>
> >>      mutex_lock(&hdmi->mutex);
> >>      hdmi->force = connector->force;
> >> +    hdmi->last_connector_result = connector->status;
> >>      dw_hdmi_update_phy_mask(hdmi);
> >>      mutex_unlock(&hdmi->mutex);
> >>  }
> >> @@ -3046,6 +3050,16 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
> >>
> >> +static void dw_hdmi_hpd_work(struct work_struct *work)
> >> +{
> >> +    struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
> >> +
> >> +    if (hdmi->bridge.dev) {
> >> +            drm_helper_hpd_irq_event(hdmi->bridge.dev);
> >
> > Nit: please consider this for the followup cleanup. The
> > drm_helper_hpd_irq_event() is not very effective: we already know which
> > bridge (and thus connector) caused the HPD event.
> >
> > Moreover, the call should be redundant as drm_bridge_hpd_notify will
> > call the registered callback, which normally would be
> > drm_bridge_connector_hpd_cb(). Internally, this function calls
> > drm_kms_helper_connector_hotplug_event().
>
> I disagree in part, based on my testing, without a call to
> drm_helper_hpd_irq_event() or drm_connector_helper_hpd_irq_event() the
> internal check_connector_changed() never seem to be reached to detect
> any connector->status and/or connector->epoch_counter changes.
>
> In my ongoing work to convert dw-hdmi to become a hdmi bridge, I have
> actually done the opposite to what you suggest here and instead fully
> dropped the call to drm_bridge_hpd_notify() made here.

That doesnt' sound correct, but maybe it's because dw_hdmi isn't using
drm_bridge_conenctor. The latter one registers a hook in the HPD
bridge, which then receives the event and performs all the
notifications. If the dw_hdmi doesn't do it (because you don't need
it), then it's fine for now. When you work on conveting dw_hdmi to
DBC, I'd recommend using the bridge notification instead (as it would
then play nice with the rest of the bridge and HDMI framework).

>
> drm_bridge_connector_detect() calls drm_bridge_connector_hpd_notify()
> so any bridges should already be notified as part of any internal
> check_connector_changed() handling.
>
> Maybe something like following could be an option:
>
>         changed = drm_connector_helper_hpd_irq_event(connector);
>         if (changed)
>                 drm_bridge_hpd_notify(bridge, connector->status);
>
> I will likely keep this as-is to keep existing behavior in a v4, as this
> patch was just about de-bouncing the existing calls being made at HPD.

Yep.

>
> Regards,
> Jonas
>
> >
> >> +            drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
> >> +    }
> >> +}
> >> +
> >>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> >>  {
> >>      struct dw_hdmi *hdmi = dev_id;
> >> @@ -3097,10 +3111,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> >>                      status == connector_status_connected ?
> >>                      "plugin" : "plugout");
> >>
> >> -            if (hdmi->bridge.dev) {
> >> -                    drm_helper_hpd_irq_event(hdmi->bridge.dev);
> >> -                    drm_bridge_hpd_notify(&hdmi->bridge, status);
> >> -            }
> >> +            mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
> >> +                             msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
> >>      }
> >>
> >>      hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> >> @@ -3420,6 +3432,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
> >>              goto err_res;
> >>      }
> >>
> >> +    INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
> >> +
> >>      ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
> >>                                      dw_hdmi_irq, IRQF_SHARED,
> >>                                      dev_name(dev), hdmi);
> >> @@ -3552,6 +3566,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
> >>
> >>  void dw_hdmi_remove(struct dw_hdmi *hdmi)
> >>  {
> >> +    disable_delayed_work_sync(&hdmi->hpd_work);
> >> +
> >>      drm_bridge_remove(&hdmi->bridge);
> >>
> >>      if (hdmi->audio && !IS_ERR(hdmi->audio))
> >> --
> >> 2.53.0
> >>
> >
>


-- 
With best wishes
Dmitry
