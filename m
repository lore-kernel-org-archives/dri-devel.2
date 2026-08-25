Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A80AC61CE3
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD6310E91B;
	Tue, 25 Aug 2026 06:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eu+NysLV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLMXdJ/f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC2310E91B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P44Dd03846937
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FVD1sEVc+eyZK4puuHJzolBf51INQuu/GiSfxhT8Fxw=; b=eu+NysLVghY9JBeD
 iboqW0lFxAjuIouMxYOzDMp1wC0M+AhdWorbqNtew1ZsAigIHXOF8Igsk4BazBpR
 NtztMejLTUEV3kpmMBIvDm7WnP+KU1wSomg5Hgr4kkkJmf0OtGb6pvhkJBukBOXy
 FoCVHiCfD+ujWqDpIokZgSPmenIiVQVijiVyIkIBpeXQCAkxt2aK/RkB0+Q/ajEb
 V4KKvKGJdc8KB1PI25jfiXMfMJ1fWN4t0ZUOCcteFuhoMZDcYuvArWBtjzYpPdCZ
 oB1ULO4brrymOsEa5yXCKfUpiQ8MRqlNZ5Ejvbt7Xax+3vJGuNJEE28E0iS0ZFmr
 MNA1lA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93pvgeau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbef1d25500so5472178a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787639391; x=1788244191;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FVD1sEVc+eyZK4puuHJzolBf51INQuu/GiSfxhT8Fxw=;
 b=eLMXdJ/fp43IQ/wWT2Ahfv04rfajarp1EhRwxR4n6+WvDEvRjf+gIXQJKhwDoIDjdN
 EimLE8YgRVINVBFDzChQzCUJ3lP7kQQKmRmc/kTrWZu6psBKzJJ4oAhDEQhDHdKB7shc
 lzNFJ7vt+oYBd5kAgBuN646WV1cWbU/sGtUgcODgvNhf5FDMKM1zbGgS7mrIq8iIolCj
 EIIGNcCS1/aK+tLboqj5W43VgIaLnoBxzhALVljVH4/VT0LeARPm+TUFAThomxIHp+rt
 RrQieRnv/hnFzCr3Spe3Snic9ZdQrnAD6k6lj5KVA6oXNvUDi6mhZu2Lh+AyBkxnVUry
 nMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639391; x=1788244191;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVD1sEVc+eyZK4puuHJzolBf51INQuu/GiSfxhT8Fxw=;
 b=GELwXBTpbLgg7q01p1KUUeraaj1msVj3EcGOIv9FIH+QUcHgulP1CPMZO/xP8Fl0ow
 MoY1gaT/7E28F/aI+N1Tb07V/y1XQoxxLEdIoX5WyPcQS2pQUXZwgKXkQrt1F0Klusvo
 imQmLij8qRCOLFawdfUv15AluSJHDYNbBCU7mMvuqUf0gRH8ic7XkjBMTOgXcTMPwRz8
 y8B65uR7BxKKcnfFbn509TUEUF0/SdLiF7tJlp6UE+VoKyR2xaQwkel8ZhdW8c1SrOW8
 z/uYr52h23dNENWbBaPbm1DcKmuqFkh3YPKf2AZ0HhNoOrnGuF5bNApYE9CXcUU4nBUr
 LEwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqA+6ibCivePyw3Y/zmcX39zK0lbQJK7vku2CbCWGu6ASilwaVe+fb+zhQtNl8HFWsNq1AJ3YrV6/A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mw5A3fntVBSzNAdxP56FrV19TGzc5lLxlYPHNJK/6zi+Xs7B5L
 oQY/PeK/ryecVC4y9E0LLMv6RfqYDxaP8SXQLd/Jc8F0YeJ3lAbtfM39JRFECQpgK5QXFfJ6w4N
 XsYpHotcIEW6WA8Bus5IztVPAXCTalRrr+Rgt2FabZe9TZKFMo1ax+SFAU/HPIbgLXkbRxuc=
X-Gm-Gg: AR+sD10VVMbSzl522X1Xs1DYmHxVHS84XmwIBo+SRxoV8QC7E7eMGtIGD7K3W2UAU29
 l3UHoTBHd9OGUrzJoK8HppfJtjT2Xkl4jSNMOS9D0+wo6hZHCZeTd3boZKhjUrWHVZI4JXBJzDs
 hD/T7UG7w9pog3+J4i8l7L1DY7sROf1+zhSDv+mCCJR4EbJlaTCg1oGlxEQQxfikeZd3UdEsUVJ
 io/TDxYi62ooUwSsJQs9PkLm4hNFKbBshw6/neW08X0W4otEyqA1xtP6EUXGairAKvA3p1bcHok
 mmEYqKs5CLHuS90AlfWreWGKv12jhP/oiutaDObJ3gcunTtshmJvZNOlMQdHUrNe4nj9U7vNx/1
 zM0ut3wIf7jaK5SD8gUJnqyhw6yGrfNKMN99orZLZQPaHv9wfB5QKTlp8/9Bp+Cd0zGcgMmjX
X-Received: by 2002:a05:6a00:9515:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8523c83193fmr7577915b3a.7.1787639391284; 
 Mon, 24 Aug 2026 23:29:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:9515:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8523c83193fmr7577832b3a.7.1787639390814; 
 Mon, 24 Aug 2026 23:29:50 -0700 (PDT)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f149af7sm2638922b3a.40.2026.08.24.23.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:29:50 -0700 (PDT)
Message-ID: <40a10b78-c35a-4738-9cb3-93237c151522@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:29:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 24/25] drm/msm/dp: add connector abstraction for
 DP MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-24-2ed6aee1867a@oss.qualcomm.com>
 <4ui4ztzjmyyg42azitguvxqcu7zs2xb5xc7cidckyugsfvv7ps@tdybmvmozukk>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4ui4ztzjmyyg42azitguvxqcu7zs2xb5xc7cidckyugsfvv7ps@tdybmvmozukk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfX1wAhdl7q84xZ
 wTGX4fBxP3Vn9zZYkTzipv/ZlKQBBzaiUPX35JPmC7xPIOAIEE2WvMqz69mL0+xZDtJETgngCXL
 R7Ntv8zQ0RR0GTH4/eP0C2W6g4jvrx8=
X-Proofpoint-GUID: xdp_9oI7rVB9DSEXPinnHye9-Sq0fVXO
X-Proofpoint-ORIG-GUID: xdp_9oI7rVB9DSEXPinnHye9-Sq0fVXO
X-Authority-Analysis: v=2.4 cv=Ru716imK c=1 sm=1 tr=0 ts=6a8d3660 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xRxkaW14WWuRBMw0ZnMA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfX/T7D1ozrgOmA
 SOXELFE2sB5RYy24jPHzIVv3Q3NPBqAyhR/sMHcImgdaWbBqaSQlt1jzl+jJuJ+am6bSzrtlCsr
 r90jjE3kDzyyKeD4Ph2EpMuTUWH08/zAB22/RDQHM+nRqTuY1bw6JN5EufQY0G2PTkp/k8dPssu
 TpJbG4u3hRgzIgSURdcCj7rlB3leEt4xV5SrDnTp3W/uaNQ/CE0RFHDkCk+xfqSp/xXVzlc13KT
 TYq3acsAxrSYf91q5gDzKRfbRguWYltX+Fs0wwoog+M8Gag40R5rmqBH+zML34n4RiOv02UlBCQ
 Kr7n8KhCyjty7H0FTNWuoNFveDyRHI9hWZ8bFGxCxGVGTDU6pa8dqpl7iPKWYlnK5ci3YDCnvTS
 lzrqptpv4XhVsetM+n52K078TSNKayeR/O6BQe3A/E8f1R7LEPP0REZYtgub9Zk2LHxOfmEmBqJ
 U57nK/hIWW/Pw/eHcaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250053
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



On 7/13/2026 8:52 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:14:45PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Introduce an MST connector abstraction for DP MST, with each MST
>> connector associated with a DP panel and connected through a DRM bridge
>> to an MST encoder.
>>
>> The connector is only used for MST helper callbacks, such as detect,
>> get_modes, and get_encoder. Display enable/disable, hotplug handling,
>> and modeset sequencing continue to be handled by the bridge path.
> 
> If it is so generic, can it be completely generic? Can we move it to the
> drm/display/* helper code? Or, at least, leverage significant parts of
> it there, providing necessary callbacks from the MSM code? It feels that
> only the connector -> encoder part is not generic enough.
> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 232 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 232 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> index 6a77fdef85e9..12b47a413793 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
>> @@ -7,6 +7,7 @@
>>   #include <drm/drm_fixed.h>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/display/drm_dp_mst_helper.h>
>> +#include <linux/pm_runtime.h>
>>   
>>   #include "dp_mst_drm.h"
>>   #include "dp_panel.h"
>> @@ -50,6 +51,18 @@ static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst
>>   	return NULL;
>>   }
>>   
>> +static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
>> +					struct drm_encoder *enc)
>> +{
>> +	int i;
>> +
> Ca> +	for (i = 0; i < mst->max_streams; i++) {
I think your comment got truncated. Could you please resend it?

>> +		if (mst->mst_encoders[i].enc == enc)
>> +			return mst->mst_encoders[i].stream_id;
>> +	}
>> +	return -1;
>> +}
>> +
>>   static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
>>   					struct msm_dp_panel *panel,
>>   					struct drm_dp_mst_atomic_payload *payload)
>> @@ -275,6 +288,224 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>>   	return rc;
>>   }
>>   
>> +/* DP MST Connector OPs */
>> +static int
>> +msm_dp_mst_connector_detect(struct drm_connector *connector,
>> +			    struct drm_modeset_acquire_ctx *ctx,
>> +			    bool force)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct msm_dp *dp_display = mst->msm_dp;
>> +	struct device *dev = dp_display->drm_dev->dev;
>> +	enum drm_connector_status status = connector_status_disconnected;
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0)
>> +		return status;
>> +
>> +	if (dp_display->mst_active)
> 
> Can it be inactive here?
> 
Yes, when we unplug, here mst_active is false.
>> +		status = drm_dp_mst_detect_port(connector,
>> +						ctx, &mst->mst_mgr, mst_conn->mst_port);
>> +
>> +	pm_runtime_put_autosuspend(dev);
>> +
>> +	return status;
>> +}
>> +
>> +static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	const struct drm_edid *drm_edid;
>> +	int rc;
>> +
>> +	drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
>> +	drm_edid_connector_update(connector, drm_edid);
>> +
>> +	rc = drm_edid_connector_add_modes(connector);
>> +
>> +	drm_edid_free(drm_edid);
>> +
>> +	return rc;
>> +}
>> +
>> +static enum drm_mode_status msm_dp_mst_connector_mode_valid(struct drm_connector *connector,
>> +							    const struct drm_display_mode *mode)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn;
>> +	struct drm_dp_mst_port *mst_port;
>> +	struct msm_dp *dp_display;
>> +	int required_pbn;
>> +
>> +	if (drm_connector_is_unregistered(connector))
>> +		return 0;
>> +
>> +	mst_conn = to_dp_mst_connector(connector);
>> +	mst_port = mst_conn->mst_port;
>> +	dp_display = mst_conn->dp_mst->msm_dp;
>> +
>> +	/* FIXME: use negotiated bpp (DSC, YUV 4:2:0, etc.); for now use
> 
> You can't use negotiated bpp, because it well might be that the
> negoation didn't happen. Anyway, mode_valid should be returning the
> modes which are even theoretically not possible to be set.
> 
>> +	 * 18bpp (6bpc) as a conservative lower bound like i915/nouveau.
>> +	 */
>> +	required_pbn = drm_dp_calc_pbn_mode(mode->clock, (6 * 3) << 4);
>> +
>> +	if (required_pbn > mst_port->full_pbn) {
>> +		drm_dbg_dp(dp_display->drm_dev, "mode:%s not supported.\n", mode->name);
>> +		return MODE_CLOCK_HIGH;
>> +	}
>> +
>> +	return msm_dp_display_mode_valid(dp_display, &connector->display_info, mode);
>> +}
>> +
>> +static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs;
>> +
>> +static struct drm_encoder *
>> +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +	struct drm_connector_state *conn_state;
>> +	struct drm_connector *iter;
>> +	struct drm_connector_list_iter conn_iter;
>> +	u32 stream_mask = 0;
>> +	u32 i;
>> +
>> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
>> +	if (!conn_state)
>> +		return NULL;
>> +
>> +	if (conn_state->best_encoder)
>> +		return conn_state->best_encoder;
>> +
>> +	drm_connector_list_iter_begin(connector->dev, &conn_iter);
>> +	drm_for_each_connector_iter(iter, &conn_iter) {
>> +		struct drm_connector_state *peer_state;
>> +		int stream_id;
>> +
>> +		if (iter == connector ||
>> +		    iter->funcs != &msm_dp_drm_mst_connector_funcs ||
>> +		    to_dp_mst_connector(iter)->dp_mst != mst)
>> +			continue;
>> +
>> +		peer_state = drm_atomic_get_new_connector_state(state, iter) ?: iter->state;
>> +		if (!peer_state || !peer_state->crtc || !peer_state->best_encoder)
>> +			continue;
>> +
>> +		stream_id = msm_dp_mst_encoder_stream_id(mst, peer_state->best_encoder);
>> +		if (stream_id >= 0 && stream_id < mst->max_streams)
>> +			stream_mask |= BIT(stream_id);
>> +	}
>> +	drm_connector_list_iter_end(&conn_iter);
>> +
>> +	for (i = 0; i < mst->max_streams; i++) {
>> +		if (!(stream_mask & BIT(i))) {
>> +			conn_state->best_encoder = mst->mst_encoders[i].enc;
>> +			return mst->mst_encoders[i].enc;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
>> +					     struct drm_atomic_commit *state)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
>> +
>> +	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
> 
> Why is it being called here? Don't we need to perform slot allocation
> too?
> 
See here: 
https://elixir.bootlin.com/linux/v7.2-rc7/source/drivers/gpu/drm/display/drm_dp_mst_topology.c#L4511

drm_dp_atomic_find_time_slots called in msm_dp_mst_stream_atomic_check().
>> +}
>> +
>> +static void dp_mst_connector_destroy(struct drm_connector *connector)
>> +{
>> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
>> +
>> +	drm_connector_cleanup(connector);
>> +	drm_dp_mst_put_port_malloc(mst_conn->mst_port);
>> +	kfree(mst_conn);
>> +}
>> +
>> +/* DRM MST callbacks */
>> +static const struct drm_connector_helper_funcs msm_dp_drm_mst_connector_helper_funcs = {
>> +	.get_modes =    msm_dp_mst_connector_get_modes,
>> +	.detect_ctx =   msm_dp_mst_connector_detect,
>> +	.mode_valid =   msm_dp_mst_connector_mode_valid,
>> +	.atomic_best_encoder = msm_dp_mst_atomic_best_encoder,
>> +	.atomic_check = msm_dp_mst_connector_atomic_check,
>> +};
>> +
>> +static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs = {
>> +	.reset = drm_atomic_helper_connector_reset,
>> +	.destroy = dp_mst_connector_destroy,
>> +	.fill_modes = drm_helper_probe_single_connector_modes,
>> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> +};
>> +
>> +static struct drm_connector *
>> +msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
>> +			 struct drm_dp_mst_port *port, const char *pathprop)
>> +{
>> +	struct msm_dp_mst *mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
>> +	struct drm_device *dev = mst->msm_dp->drm_dev;
>> +	struct msm_dp_mst_connector *mst_conn;
>> +	struct drm_connector *connector;
>> +	int rc, i;
>> +
>> +	mst_conn = kzalloc_obj(*mst_conn);
>> +	if (!mst_conn)
>> +		return NULL;
>> +
>> +	connector = &mst_conn->connector;
>> +	rc = drm_connector_dynamic_init(dev, connector,
>> +					&msm_dp_drm_mst_connector_funcs,
>> +					DRM_MODE_CONNECTOR_DisplayPort, NULL);
>> +	if (rc)
>> +		goto err_free;
>> +
>> +	mst_conn->dp_mst = mst;
>> +
>> +	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_funcs);
>> +	connector->funcs->reset(connector);
>> +
>> +	/* add all encoders as possible encoders */
>> +	for (i = 0; i < mst->max_streams; i++) {
>> +		rc = drm_connector_attach_encoder(connector, mst->mst_encoders[i].enc);
>> +		if (rc) {
>> +			drm_err(dev, "[MST] failed to attach encoder:%u to conn:%d rc:%d\n",
>> +				mst->mst_encoders[i].enc->base.id,
>> +				connector->base.id, rc);
>> +			goto err_connector;
>> +		}
>> +	}
>> +
>> +	mst_conn->mst_port = port;
>> +	drm_dp_mst_get_port_malloc(port);
>> +
>> +	drm_object_attach_property(&connector->base,
>> +				   dev->mode_config.path_property, 0);
>> +	drm_object_attach_property(&connector->base,
>> +				   dev->mode_config.tile_property, 0);
>> +	drm_connector_set_path_property(connector, pathprop);
>> +
>> +	drm_dbg_kms(dev, "[MST] add_connector done conn:%d max_streams:%u\n",
>> +		    connector->base.id, mst->max_streams);
>> +
>> +	return connector;
>> +
>> +err_connector:
>> +	drm_connector_cleanup(connector);
>> +err_free:
>> +	kfree(mst_conn);
>> +	return NULL;
>> +}
>> +
>> +static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
>> +	.add_connector = msm_dp_mst_add_connector,
>> +};
>> +
>>   int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
>>   {
>>   	struct drm_device *dev = dp_display->drm_dev;
>> @@ -285,6 +516,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
>>   	if (!mst)
>>   		return -ENOMEM;
>>   
>> +	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
>>   	mst->msm_dp = dp_display;
>>   	mst->max_streams = max_streams;
>>   	mst->dp_aux = drm_aux;
>>
>> -- 
>> 2.43.0
>>
> 

