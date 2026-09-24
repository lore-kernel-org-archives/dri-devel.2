Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB08C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FEC910E0EB;
	Thu, 24 Sep 2026 19:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jS9yJKHM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKWB3FJr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ED810E0EB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:33:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdZhE3247770
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sJZ54tOnY46EejWm4rjxArav
 nzXOLrt8zf7GCS5TDK8=; b=jS9yJKHMHDuk+XIpOD+HvvpR6+DLNjInLGmc8HvM
 FlF+SyiAkz00wLfIOqWsWtEYTtQrcPZxu7EcfBN4VCwqlJOzlme52tJK/Qtzf1xx
 VmZHpyayLVf5EgYcSFWzQ0JX3vfyOjKhuyxk8vJkrGZkUNrJEtOmj6NyUPUUudpW
 kbegPpGQlXjgPx22zkmpdvLLlYJ8d7d+2dTglKSGOXGhLMkvHSQbyjzuyWBv+8fb
 NwryjKAy4NooCi8XZI+zfAN2eMLl5Chju0i5o+V+E4vOEuhbK73jerl67fmyy74u
 3fYPzmDsbspnmJqAR8sGpbrSqVsORW33lhyh/CVV0lXmyA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881rhtk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:33:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c58d35c0aso22674eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790278393; x=1790883193;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJZ54tOnY46EejWm4rjxAravnzXOLrt8zf7GCS5TDK8=;
 b=YKWB3FJrlyU0mplcBbQ0vTS4/7PuixoaILEc7dPkSzfXObaLFx9aVpLfQY3HhKlZ9K
 zX821rqLRxVmfTbt9LLy4BxiwYU1U6M4itpoIsnEn3mSSy0+ZnrukZ90xJE7WmCj7PCX
 SB/dgKEcQtmQtTaN9TyhkuAbcrtwWlUaWrxQuP1VdQJluUUaiVeNk6mCH6iBYtIBuX+c
 QZ1p94qiIN1Z0r5KtIGtdUUCbCg9D/QfXx+IOCe5TXHbhvgTUoYB/gYriuzhd0m9OgDo
 zW5Phuxl6/rKd6kQCcahDq9XSqLJAhr8X06ihK10eZIf4oRbDhdEwJVq1qKmJZWVTuHK
 JI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790278393; x=1790883193;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJZ54tOnY46EejWm4rjxAravnzXOLrt8zf7GCS5TDK8=;
 b=r3V54Y8eBQeMHBakAnjdSt6qrGHvdgYXOTKbK3gVFfOUJQ40fj6TWOoe9p8H6LdwbJ
 lZYTHhE4IthXj+1BIpcj/0EeumtbebWKT8sSg+lk2YdP+oVjvgeQH9qV1I+5qRDdyMH9
 gD3n86fruwZlvkxqYHmLItSe8rvBBhUXVpMf5l+Cy7oGWPdGqX8AsfHYaEsHRDiW+yOg
 izcRpdjOYc28ljbGm59TCRz1W3U+BGblV46F2ZR8KwjwntES9N+/ZXg0bEJqDmckhBf6
 D8zfgObCDKt9oVE18gVFayNLi4JVjXRhw6rj0O5ANzK4X1GaGB9jd2WvuzN8zTdq+/Cj
 yNJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQdpKYqDJyJuBycJRgeCeb8GEQPDttVhOeffT2e5eopKPlQkL8PVhIvEDat75WMQ9JzMr+6mlcywY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE/osCGPwxi9Qbv4GI5b/uE4SiosVocSsxWlHs1eoCcM9mubeG
 BZvoUStj1QUIzhgkA91GUC73VzZUirTEmmn2gHj9nX/JB4ONm6pG7Jq99tLyIyVEY97PhLoS01w
 hIybu5v4nbh0KP5VQsKjyhqcanarLzfTaXLnpSPf66ADUa4zITimit9+JoVFYDMvaUByegNs=
X-Gm-Gg: AYBFou0AKKMqJ1cETcbabFWjj8zr/C2g6aEfaJq/5ydMalxHF1JJ7IIPpth3T4Sr1cd
 RkxhX0nqESjrQz2ePDpv8mW+7UrYDs+LF6oUIUCrf1Cbpb9c1Px4mgcNXorehCzgTF+UvP/D6qf
 uuUvUdNZOQnYCENd1oZHqdIfZsikiMH5iKE+nJ68B9JB6Dug5zHBYec8FoDtJ3vsVZKqcFPcyoD
 G5MJhAy0QNyCuZ/bhUM6nVCwNIa1umsvt7uILX4b+zb8gY4gt+irWK5gmbusK0Wo+4BZ4ii5eLi
 10Aiy7Jta/XbVohhbPl5PqEcoJa6qp5i7o4lYVxLdKgzr2qmpwl2kVPA1NTY97ivti66vr3pBEz
 DHgTMekX7qhdFh5llnhVRp/u9GGO91X9Bc75NWNZorDtIyEOaqnUEO3uQvcZVmGW/VBd5IW+GXM
 DBFG3j1GX7yOGcJ7HT/FOy
X-Received: by 2002:a05:7022:b048:20b0:143:858d:fb0e with SMTP id
 a92af1059eb24-14503d6711dmr4536390c88.0.1790278392281; 
 Thu, 24 Sep 2026 12:33:12 -0700 (PDT)
X-Received: by 2002:a05:7022:b048:20b0:143:858d:fb0e with SMTP id
 a92af1059eb24-14503d6711dmr4536348c88.0.1790278391435; 
 Thu, 24 Sep 2026 12:33:11 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc45f03sm653140c88.7.2026.09.24.12.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:33:10 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:03:01 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Ravi Agola <raviagol@qti.qualcomm.com>
Subject: Re: [PATCH v4] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
Message-ID: <arV67VEl259RsoYe@hu-vishsain-blr.qualcomm.com>
References: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
 <96be97088cc0d436414f0f9552fa7442312ac719@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96be97088cc0d436414f0f9552fa7442312ac719@intel.com>
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab57af9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=egjODiOu6V-NXdxj13MA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3OSBTYWx0ZWRfX7ZX6jvirSR+M
 FBqhQOKA9qylPBS7lPGJVEct1k+sNMR+3kOKvyBug5TaJr+tFC/g4DDDu+kPv3hYytO81PtsgUV
 C1WUW/Il3hjVeD6Vj/PneOukOd2vdWlGC9wm7WLQWRwrGLbhcQCfv/chBQsBz8pCtihkbDgvryD
 XiWPVGZtIwoepfcdwLQe4oyvAgANOUtf5lJbmQPYvuSTtIIuiAKDqXp7cGTPsONH7y46gBZsqLx
 eOZqhnOTQesbze4i8ysAxu1VptEtzTjEg0vs1gGlDQFHfnIps9nSRwxgvEhCH3NN1z6rS4yXS4D
 qph8KiuetxWmVm9fQyGbm2B00ilSPjJKv8IOpQnJnli31yJdOh4602PRrS6VYhBGyGeIzrxpf0C
 /7QW4x82pB5M8vxzjfVvVCAtsvgVBc2gX8w1v5tfOePIFNi9z6RHSfzV4oYn44N/Uol710mtGpy
 3h77RgR2d6Rl+JMmBEQ==
X-Proofpoint-ORIG-GUID: MNhSUuzlgKeHtIQIjgBviUiu3NZ3EOvc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3OSBTYWx0ZWRfX+BKigYLGa+ji
 N22E0am2x2+PqaG/5mSrc+x+cLHpYik3Uu4ylFqnp0vBIlVjGDWKMYYuNXmJf0QalPcsUegXA1x
 BtYiXvSnr/E7uGIasSyfa6Wx3ek+ha0=
X-Proofpoint-GUID: MNhSUuzlgKeHtIQIjgBviUiu3NZ3EOvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240079
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

On Tue, Sep 22, 2026 at 11:55:01AM +0300, Jani Nikula wrote:
> On Tue, 22 Sep 2026, vishnu.saini@oss.qualcomm.com wrote:
> > From: Ravi Agola <raviagol@qti.qualcomm.com>
> >
> > The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
> > previously limited EDID reading to 2 blocks and prevented support
> > for displays exposing more than 2 EDID blocks.
> >
> > Add driver support to fetch up to 4 EDID blocks by re-triggering
> > EDID access after the first 2 blocks are read. For block 0 and 2,
> > set the EDID ready flag in 0xb028 so the bridge can expose the
> > corresponding EDID blocks, then retry the read until the expected
> > EDID is fetched.
> >
> > Reset the edid_read flag on HPD disconnect so that the next
> > connect event triggers a fresh EDID fetch.
> >
> > Increase EDID wait time from 500ms to 1000ms, On Qualcomm rb3gen2
> > platform sometimes edid read interrupt is coming 600-650 ms after
> > HPD interrupt resulting in edid read failure.
> >
> > Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > - Rebased onto latest drm-misc-next.
> > - No functional changes; replied inline to the two Sashiko-bot
> >   review comments on v3
> > - Link to v3: https://lore.kernel.org/r/20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com
> >
> > Changes in v3:
> > - moved edid_read state change inside mutex lock     [sashiko-bot]
> > - returned -ETIMEOUT when retry_cnt is exhausted without a match.    [Sashiko-bot]
> > - Increased edid wait timeout from 500ms to 1000ms as edid interrupt is sometimes taking around 650ms time
> > - Link to v2: https://lore.kernel.org/r/20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com
> >
> > Changes in v2:
> > - Removed memcpy and doing edid fetch everytime. Required an update in firmware as well for edid block0 reset.
> > - Verified patch with existing firmware V5.0.21, patch is not causing any regression if V5.0.21 firmware is used.
> > - Firmware V5.0.22 is required with this patch to support edid fetch on more than 2 edid block monitors.
> > - Link to v1: https://lore.kernel.org/r/20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 80 +++++++++++++++++++++++++-----
> >  1 file changed, 68 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> > index b3bb7f2cebb3..a74077a65f62 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> > @@ -28,7 +28,7 @@
> >  #include <drm/display/drm_hdmi_audio_helper.h>
> >  
> >  #define EDID_BLOCK_SIZE	128
> > -#define EDID_NUM_BLOCKS	2
> > +#define EDID_NUM_BLOCKS	4
> >  
> >  #define FW_FILE "lt9611uxc_fw.bin"
> >  
> > @@ -167,6 +167,8 @@ static void lt9611uxc_hpd_work(struct work_struct *work)
> >  
> >  	mutex_lock(&lt9611uxc->ocm_lock);
> >  	connected = lt9611uxc->hdmi_connected;
> > +	if (!connected)
> > +		lt9611uxc->edid_read = false;
> >  	mutex_unlock(&lt9611uxc->ocm_lock);
> >  
> >  	drm_bridge_hpd_notify(&lt9611uxc->bridge,
> > @@ -380,13 +382,39 @@ lt9611uxc_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
> >  static int lt9611uxc_wait_for_edid(struct lt9611uxc *lt9611uxc)
> >  {
> >  	return wait_event_interruptible_timeout(lt9611uxc->wq, lt9611uxc->edid_read,
> > -			msecs_to_jiffies(500));
> > +			msecs_to_jiffies(1000));
> > +}
> > +
> > +static int lt9611uxc_read_edid_block(struct lt9611uxc *lt9611uxc, unsigned int block,
> > +				     u8 *buf,  size_t len)
> > +{
> > +	int ret;
> > +
> > +	lt9611uxc_lock(lt9611uxc);
> > +
> > +	regmap_write(lt9611uxc->regmap, 0xb00a, (block % 2) * EDID_BLOCK_SIZE);
> > +
> > +	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> > +	if (ret) {
> > +		dev_err(lt9611uxc->dev, "edid block %d read failed: %d\n", block, ret);
> > +		lt9611uxc_unlock(lt9611uxc);
> > +		return -EINVAL;
> > +	}
> > +	lt9611uxc_unlock(lt9611uxc);
> > +
> > +	return ret;
> >  }
> >  
> >  static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
> >  {
> >  	struct lt9611uxc *lt9611uxc = data;
> > -	int ret;
> > +	int ret = 0;
> > +	int retry_cnt = 10;
> > +	unsigned int edid_ready_flag = 0;
> > +	bool header_matched;
> > +	bool edid_valid = false;
> > +	const u8 edid_header[8] = { 0x00, 0xFF, 0xFF, 0xFF,
> > +				    0xFF, 0xFF, 0xFF, 0x00 };
> >  
> >  	if (len > EDID_BLOCK_SIZE)
> >  		return -EINVAL;
> > @@ -394,20 +422,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 *buf, unsigned int block, siz
> >  	if (block >= EDID_NUM_BLOCKS)
> >  		return -EINVAL;
> >  
> > -	lt9611uxc_lock(lt9611uxc);
> > +	if (block == 0 || block == 2) {
> >  
> > -	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
> > +		lt9611uxc_lock(lt9611uxc);
> >  
> > -	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
> > +		edid_ready_flag = (block == 0) ? BIT(0) : BIT(1);
> >  
> > -	ret = regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> > -	if (ret)
> > -		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
> > +		/*
> > +		 * Set the EDID ready flag so that lt9611uxc can fetch correct EDID block
> > +		 */
> > +		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
> >  
> > -	lt9611uxc_unlock(lt9611uxc);
> > +		lt9611uxc_unlock(lt9611uxc);
> >  
> > -	return 0;
> > -};
> > +		do {
> > +			msleep(100);
> > +			ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> > +			if (ret)
> > +				break;
> > +			/*
> > +			 * Compare first 8 bytes of EDID header for block 0 and block 2
> > +			 * to confirm EDID read successfully
> > +			 */
> > +			header_matched = (memcmp(edid_header, buf, 8) == 0);
> > +			edid_valid = (block == 0 && header_matched) ||
> > +				     (block == 2 && !header_matched);
> > +			if (edid_valid)
> > +				break;
> > +
> > +		} while (retry_cnt-- > 0);
> 
> What's the purpose of the above dance? Why do you have to try ten times,
> and what's with the header matching? None of this is explained in the
> commit message.

Fair, sorry for the missing explanation. The bridge only buffers 2
EDID blocks at a time at a fixed offset (block % 2). Writing 0xb028
re-triggers an asynchronous fetch of a fresh pair of blocks from the
sink, and the bridge has no "fetch done" status to wait on, so we
poll the buffer instead: 10 retries at 100ms apart, i.e. up to 1s,
which covers the fetch latency we've observed on this bridge (same
ballpark as the 600-650ms EDID-interrupt delay mentioned in the
commit message).

The header check is how we detect the new pair actually landed rather
than stale data from the previous fetch: block 0 always starts with
the fixed EDID header magic, so we accept it once that magic appears;
block 2 (an extension block) never carries that magic, so we accept it
once the previous block 0's leftover header is gone.

This will allow EDID fetch for more than 2 block monitors like Dell Curved Monitor (Model - U4021QW)

I will improve the commit msg in next revision.
> BR,
> Jani.
> 
> 
> > +
> > +		if (!ret && !edid_valid)
> > +			ret = -ETIMEDOUT;
> > +	} else {
> > +		ret = lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> > +
> > +		lt9611uxc_lock(lt9611uxc);
> > +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> > +		lt9611uxc_unlock(lt9611uxc);
> > +	}
> > +
> > +	return ret;
> > +}
> >  
> >  static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *bridge,
> >  							 struct drm_connector *connector)
> >
> > ---
> > base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271
> > change-id: 20260517-lt9611usc_edid34_misc_next-b02592de0b25
> >
> > Best regards,
> 
> -- 
> Jani Nikula, Intel
