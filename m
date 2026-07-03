Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AC3C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A58E10E5E2;
	Fri,  3 Jul 2026 12:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLIw3pWO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/hrtwoP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB90A10E5E2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:57:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663BqhJZ4091101
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 12:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4MY2427j/ts83OjHXrzZDI75
 V9a1sPHf8LfhklDWR+k=; b=ZLIw3pWODWerMjtOvtcf+P48gqgvZwhl+ZTY8Axd
 0WVanM+2whMGmWoVTV6HmoMnsJBSDF1gNEJA40SwF5ERi8bG3QQsEfK3t0hURB55
 0kQel7uGELv4AlkWTP8wfsOFUTHT0l8taUA3QrcDHivKFE/xld3niMuCMREBAVMP
 sQkZNjZOsNfdx4OfP3A8jG5T906/Kba8T8lMch+iKK6aWBOOtU/+vj62WKWIFyYP
 1nUiVMuufxHb7nJYyrjaMpyck7wrFa1bmKAR3JVP0iypt8ZE2IEAfJnDC+P5g0Dm
 JEeE0zFsI3McHU8fuRT+anLHzeixU+QSyFZuPOIKUbTXIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj07y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:57:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9960cf96cso10240635ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783083439; x=1783688239;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4MY2427j/ts83OjHXrzZDI75V9a1sPHf8LfhklDWR+k=;
 b=a/hrtwoP+esUBDaNcHb3Vsd6t0mm2tmc6vkvw4n/KQ5YlctL6A+e/kQPUuJ/8t4x5q
 3sNXKxMLf/QpGfXDv2KgLaoZmLtzLawchko0d4hl3iZUEgLA6HLrnUii4BqjQdNfTlmZ
 45DPlYbZ62GuZ8UXDp2I3Iwgc8XmmikOSGAxNS5aOdWPjvtPLI/0QYJ1i8tmqZfWUCIf
 kGEhZ9c31b5vQ9TqgomJxjiYiUC5YlAY7TxsCp6zgnU4uHnmtv9zSSfERINfWZ4lg9Pa
 lh7RIXVK8EdMiVkpAL3f0EGyV5XXY/WO8krwzjykXT0Kc44rUPHhgzXKYt7Y9u9RBdrS
 J+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083439; x=1783688239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MY2427j/ts83OjHXrzZDI75V9a1sPHf8LfhklDWR+k=;
 b=kiwxBFVKUZWBp4y7CSBg28+m4b5+lhfpIlEFLCI4KSOLH2SjW3eCpveUZ9PKrH9TVK
 HNHkxa/FXCi4YUR1ReEyaFQGLOu6N02ApfU+VG62wIuoiUCYHyvF2LhSfH/kMDCD1zLL
 5lvriuMSjVliwmC41aVIoliO54XRFeueBcrNieanLIag+WZGIko2zNH6hgQjr7Owg3qV
 SBY5E0qen+0wJVwTSyCLmRWPkyIQgys7zZ94StIN1HXQJJBuUSMaAisWtUk5wgDWuzUS
 n6ITeuiNlh70wLjOKY/0KbSRdZ5+DzPkEQUh6mgQoiW6kyAvIXXIducbn1BGX79JLOjo
 LJcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UAZ3IBM81NfWc+TPHwk+FL81GlK9Ds+3ElbrN4t0u9DVKCnHw9AO1zqZpWMLodDMLccJIG4B93XI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8mNpOV5ZYWhvDHw3KK32UA3ATrubm7BjzZU2Xv1eVUs0ThK8t
 X0Hx5Vs5uEzwvVMEWwxBUFrSAn6itdSLao4jJHcgUvXy6e74kViOOBjMcFB22BewBJ9yOU46csi
 fDOzCIKe6uGSyMsJIIzcKecIFbcdnxB+a78k6CSSWW5ZL845tGH8Pc4qZ8UZq80O/CYz1X2A=
X-Gm-Gg: AfdE7cmJlGNB7F4E/lyvr3pqm5hD9bnjIOUd2ouY/N8M/U2OlHGhs1h8i1QrBgRStTx
 u0PeBQxA5xV6WLN2boHaBjAYm4bhmDvWKf9/nL7EUeNUV5niuQMK9Hou1nc5yJJqxlUJcNS42Ng
 YJ27vCk6gJGGqYNDZXDuhl5Km9CEAvZYQsBl67BOipdlEyjE6clboT42MKV2kpLEDBppQ0ray6x
 7ApkyVbnINmICH/2sg3GXng/NHbndOOe7ILwSzZJ+w/14AvoP1mRYcju1pD6JE+ULqiWUSGRUxu
 721+oFhFcargk3i+6hqoktkckxfa8WOP6h8hRgcz7NCJjcKzWGjKT4E4wiilNborTvkUksYwMHE
 u00Ene8q4xJZJomJ/OwnaaaSsp0WGqe4TekVb
X-Received: by 2002:a05:6a21:e58d:b0:39f:91e9:cada with SMTP id
 adf61e73a8af0-3bfed1bf7b0mr12177779637.9.1783083439362; 
 Fri, 03 Jul 2026 05:57:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:e58d:b0:39f:91e9:cada with SMTP id
 adf61e73a8af0-3bfed1bf7b0mr12177729637.9.1783083438782; 
 Fri, 03 Jul 2026 05:57:18 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd2362sm22192457eec.20.2026.07.03.05.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 05:57:18 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:27:08 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 3/4] drm-bridge: lontium lt9611c: fixes and improvements
Message-ID: <akexpMGzU9HDTcDb@hu-mdsor-hyd.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-3-42abbcd3bb1e@oss.qualcomm.com>
 <a64pcvbmkkszgnokarsig5gyanviqcvdxhbknkfciylpuein4u@xmn6znafguxh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64pcvbmkkszgnokarsig5gyanviqcvdxhbknkfciylpuein4u@xmn6znafguxh>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfXzbAl5HFhgGU+
 PNfnWZs803YCb2badCaSj656y2Ne8bdqq4geQgJtGYYErA8Jafu+EvtRUfM2Us3L18eERAWWCDW
 wLDZ9RV3dFb6cI0YmFMmHchbdoa7knw=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47b1b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=K1nJ1lxNh3oVjQTzV4IA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Tx93taYZ9dJtCEEUKe-VPEt0wBvTQ2Ec
X-Proofpoint-GUID: Tx93taYZ9dJtCEEUKe-VPEt0wBvTQ2Ec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX1FYa0QuOUmN5
 wU/23Zu9n/R/gioXBNLOeioLAvuC1yF+NFFbu44zLP9/1gNTyXw7FPtuDKAmSrQ2t7EXjSKvrqg
 W45aLrHKl9qg5LPVFwhcX0DFLsUIV5NFwzQTjF7xwwzUSG6N0VSqhy/oOGGmVwceYzsiEwv3zlx
 DWuwckEB7SDK5OzbNgTyNsEDGGnfMjIZpdR83BrKJkyjiM0MjDLJYCFM+1+zJ/MVk7dwqRoTWYU
 N0rsU80qIlmlx9n+6o5jFDql99SDX34L1FTtYpv1TCUf35BsK+SfRd6/0u6tbwagbOMyW1Jwmaw
 LBghmfuK/uo4jQnKL0G9mU7nnBKKtES1FtTR8uErbRtsSaAOYkQVCzk8zuzJV0veyPY5fJjT25e
 IOnWFDyxLNVS5T2/pTluAHF/nvoCIUN1NU9dkWcK9p1uIo2WkdIyQxf3WQoQfk0hqaV9cizbEwy
 saLmhcBmoOicrpQGR1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030126
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

On Fri, Jun 26, 2026 at 11:30:56PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:44:58AM +0530, Mohit Dsor wrote:
> > Remove two redundant lt9611c_reset() calls:
> > 
> > 1. In lt9611c_bridge_atomic_pre_enable(): a reset is already performed
> >    during probe and resume; calling it again on every display enable
> >    adds ~440ms of unnecessary latency.
> > 
> > 2. At the end of lt9611c_probe(): a reset was already performed earlier
> >    in probe before lt9611c_lock(). The second reset is redundant.
> > 
> > Also, the DRM HDMI bridge framework requires hdmi_write_hdmi_infoframe and
> > hdmi_clear_hdmi_infoframe callbacks for HDMI vendor-specific infoframe
> > (VSI) support, used for features such as HDR metadata signalling.
> > 
> > This patch add stub implementations that return success. Wire them into the bridge
> > function table.
> > 
> > Also, Store the chip variant enum value in the of_match_table .data field and
> > retrieve it via of_device_get_match_data() when probing from a DT node.
> > Fall back to i2c_device_id.driver_data for non-DT (e.g. ACPI) probe
> > paths.
> > 
> > This is the standard kernel pattern for passing per-compatible data
> > through the OF match table, and avoids relying solely on the I2C device
> > ID table for chip type detection when DT is available.
> > 
> > Populate bridge.vendor and bridge.product so the DRM HDMI framework can
> > report the correct manufacturer and product name in the HDMI connector
> > properties (visible via xrandr --prop and related sysfs entries).
> 
> I was going to write that this should be split into several commits, but
> then... I stumbled upon a fact that the driver is not a part of the
> drm-misc. So, instead of posting an update for the not-yet-merged
> driver, please post new iteration of the LT9611C series. Don't forget to
> drop the R-B tags where applicable.
> 
We will merge these changes in base patch only.
> > 
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > index b0402726367e..fe51f4978546 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -622,7 +622,6 @@ static void lt9611c_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> >  	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> >  	if (ret)
> >  		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> > -	lt9611c_reset(lt9611c);
> >  }
> >  
> >  static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> > @@ -777,6 +776,17 @@ static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
> >  	return 0;
> >  }
> >  
> > +static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
> > +					     const u8 *buffer, size_t len)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
> > +{
> > +	return 0;
> > +}
> 
> Definite NAK. The purpose of the callbacks is to write the infoframe.
> Purpose of the check in the DRM framework is to ensure that the frame is
> actually written. Please work with Lontium and find a way to write HDMI
> / HVS, SPD and HDR infoframes.
> 
We will implement these callbaks.
> > +
> >  static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
> >  					      const u8 *buffer, size_t len)
> >  {
> > @@ -895,6 +905,8 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
> >  	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
> >  	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
> >  	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
> > +	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
> > +	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
> >  	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
> >  	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
> >  
> > @@ -1025,6 +1037,13 @@ static int lt9611c_probe(struct i2c_client *client)
> >  	lt9611c->dev = dev;
> >  	lt9611c->client = client;
> >  	lt9611c->chip_type = id->driver_data;
> > +
> > +	if (dev->of_node) {
> > +		lt9611c->chip_type = (uintptr_t)of_device_get_match_data(dev);
> > +	} else {
> > +		lt9611c->chip_type = id->driver_data;
> > +	}
> 
> Use i2c_get_match_data(). But, also, why? The driver will likely not
> work w/o the OF in place, there is little point in doing something else.
> 
we will use i2c_get_match_data. id->driver_data is in base patch, we
will check with lontium for this.
> > +
> >  	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to init mutex\n");
> 
> -- 
> With best wishes
> Dmitry
