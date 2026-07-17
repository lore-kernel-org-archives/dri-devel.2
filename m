Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B9C44512
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3B710E407;
	Fri, 17 Jul 2026 03:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxPv+dDN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xn6nTYFi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8BE10E407
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:08:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H33rE8607317
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TXyVGivf3UWZOqVUOzlxgpcD7lIywizl54v1ZomEtRs=; b=AxPv+dDNNMbwYNrZ
 6DV69VbHQ8VNc4FrHjJPQG76qpoXI8ZbmDULTkGqYxDHPt+H0IFnBosOnk8x8MWX
 pBxyF+x5vn3Z7NQLQx/KTDTC0zm74gMZpjXUKXAKxkFmaprURWc9e7YSjeKZcb58
 8jc0emcdvk43QPtxo0PMTpncPawVtK5W39tLRA+QCsImFy+ZBMK9kLOm030e1opE
 sKMJl1mCKNKaucEGJPxx5KkxhiFcKWl7tEYbUkn4rRjrEm3Pzka/DFc0umerVUXl
 NkDQTRmVsjZSQL2UW/G2wzUQAUGckASuzvu3gnDjphoVHVOnpTVJImo2mJSdCA9E
 +S3tAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10cd37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:08:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so592724a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784257725; x=1784862525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TXyVGivf3UWZOqVUOzlxgpcD7lIywizl54v1ZomEtRs=;
 b=Xn6nTYFi0fvG/qQ+WB0ouGAG7VpxD014a6K5FbJ5Zt5h9rpacfG4GDHVRvHR5tcVgO
 LwYmMl//8L/SCDKYHy8F65ftotkBEJe5T5HVel9HpWzcG74GYMz8RELVtsifsARYGM6B
 ayzXTF47zA2xRG0mQ9Q8x9/z7l6g0QtPWs4wL1myRXuR8+/X/6Gm6CZTLa5KJ6lkMuUa
 uuPBNw8iyObSg9d4HSgH7DbSJbXUwgS2uKWz3NR+DNxzYWNYqNgfbFfH2SDg/nzEBhgn
 geCj5sYl/rT68OX7W2VCMpSlwIPVuH2qcH1RfIzsPeUvC3bipEu/sFkfK8pLWCaTzYyJ
 1drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784257725; x=1784862525;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXyVGivf3UWZOqVUOzlxgpcD7lIywizl54v1ZomEtRs=;
 b=b6H48Pgj89oC4lAz8xRHd6PU5gsEmynLP9SSKNLFgXFzbHv0wJer6mdo4/PLNuI7oi
 0rJav7u8kjXBf89t3gla6vRAxGVY7AjK92iflhSkOi+FyMA/Or+b2jURDdVTUqt4kDyB
 GS6UlrnEXIvkstnbob/RtCgJJUEFmmxIVtuUWk1DqQPbKy1GVQam9FXHFf4NNrdFynHz
 Qtfm0uDiZRZOxjFZq+TkbMPJGuwHpWb/oPyuICH9Y5yx+siMSq2s5dzLb1v9TxqW1eKx
 8xbDREVK1jkNs6ISC2NI7WyhhqYxrNFswGrdbO0SIFgBlTqwe+wBcnS5cDVj+8p37hNS
 +jeg==
X-Gm-Message-State: AOJu0YxtkFlxRYqdiXdKn9pHLy/VqFqGB8jUzixsrCZ2+inhQlGitK8L
 nRRHkSoGVbP8uGPoYurXy5/y7v+/CS+Iv+9+qGicQRmT2xVbMG3+Nhi66zjJhWFsH6gG+equ+2u
 WAWfwjr+Lk8Ww9yD+iET5qpmQFohhKD19Jc0+UECCBWZmxhklVQvmbCfenpQAdYk5/ojUqJ2Qyj
 gVfcg=
X-Gm-Gg: AfdE7ckgRm1qZ1Nc+xfwEsMdkL6D5loIt5O+vJPmZjAoWXSiqrpEOfaW3wXzaX8Wu/7
 q0buI5mYbVS4iMNHiqqE6XclvonE1bsd6tIrvteC7YtCNMadmRAsLXThDpdG4pvOA0zwYgW4MkN
 eBRp4Om/q4GmVd2pjRwg2fc+tYoEQD9FDf0wJ43juGCTcHBpMvqh8hO/h1JD5cshItDR6XDHuL3
 fXXvWi2VIMeWNrtANic8gOc23Ljf+ybY0AvVOd6BCYFw4ziMWFt++evfrzLQldPlWtcxwZ0S5VF
 frjyVYxq4suk1qeraYL0EKEPhb2ZlAgEm0gfF8KRfSsDbU93MLq/+B3ryHuMB4p1cH+NqHbJes0
 hKTBm4ATGmxZYKViWe6nMZtLeV0IgqGZkMFkV3TGsodgEYm96Ug5Aj/nu9N/H7sOnxo7JXSQk
X-Received: by 2002:a17:90b:2785:b0:380:15fa:c5b2 with SMTP id
 98e67ed59e1d1-38e4b42dafemr723815a91.18.1784257725161; 
 Thu, 16 Jul 2026 20:08:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:380:15fa:c5b2 with SMTP id
 98e67ed59e1d1-38e4b42dafemr723786a91.18.1784257724618; 
 Thu, 16 Jul 2026 20:08:44 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e48085853sm144811a91.2.2026.07.16.20.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 20:08:44 -0700 (PDT)
Message-ID: <d3c1909e-6ae6-459d-8bf5-8e8c5aff4ce7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:08:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/15] drm/msm/dp: make bridge helpers use dp_display
 to allow re-use
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260609-dp_mstclean-v7-13-ea04113e8233@oss.qualcomm.com>
 <20260609100904.452091F00893@smtp.kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260609100904.452091F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rRmTMAu0PVVOvxAuqb5_TlWG76hamMTk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAyOCBTYWx0ZWRfXwNpb50elcgoj
 K63eQ0shr040fkflK+Ulg44cE4ROHjRaSb7WPG8nq4aZTHT2GfQIIKhZg0q9I6GTepC42+Z4Fvx
 7Nfmu/HqlisX+8eVYVqMylrnCdjr+B+7H1532BDr9jZXjb8PB6BJ9KPuzDqGMPBBmm2Rg6T+Qc8
 EEcSvKohIWrQiKGTmibPDBs9Jlbx/lYq9sgX+6C1ynJtEnF1ns/l7STU9ekBQtzIeBvwPikBv9z
 z4f5QXAWIwx4chkW1U0+KzFwkCl90OgjJS/IJm1rgqFJFxfVmE2dpLyIJ7ojOgMur4vcbA2IxVa
 ioBCDN4uZojh+GaPfdsg5DcJa13k7jSDG33asZSCXLbkelT2yr1ZubTfyy9IcVBP9AcXU/5oi7d
 KdebzmGgoGN9xGSB0hJs2Z7AXRP/MnJuc+KQ6aoq3lsfAK3CxJAoPtdVPT75hnxCGfYSJLQeb4C
 mSeirKvVdOWSVzIDoZQ==
X-Proofpoint-GUID: rRmTMAu0PVVOvxAuqb5_TlWG76hamMTk
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a599cbe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=z6SnXkDR-izpW1DdgxoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAyOCBTYWx0ZWRfX/9q0TyfMheQ4
 BghtjQghEyg0vZyc0IFMZRkqCWTf1P9m9Q5uu0nTqfXBuQfsseBf0zDnf7dTwmteLnO4RaR/Jay
 VnNKImlICF472Z7uZ56d6l1K7j0gFxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170028
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



On 6/9/2026 6:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Hardcoded base encoder in `msm_dp_display_atomic_enable` breaks MST reuse
> - [Low] Kernel-doc mismatch for `msm_dp_display_mode_valid`
> 
> Pre-existing issues:
> - [High] `msm_dp_display_mode_valid` ignores the `info` parameter, validating against the wrong sink in MST
> --
> 
> commit 79702b8fc2a6d1a516b0d64051edab10a8d7764e
> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Subject: drm/msm/dp: make bridge helpers use dp_display to allow re-use
> 
> This commit modifies the DP bridge helpers to directly take the dp_display
> object rather than a drm_bridge pointer. This refactoring is intended to
> allow the MST bridge to reuse the same helpers.
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index f1970e6dd7e46..cdb7dd4cd7cbd 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -738,24 +738,21 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>>   
>>   /**
>>    * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
>> - * @bridge: Pointer to drm bridge structure
>> + * @dp: Pointer to dp display structure
>>    * @info: display info
>>    * @mode: Pointer to drm mode structure
>>    * Returns: Validity status for specified mode
>>    */
> 
> [Severity: Low]
> This isn't a bug, but there is a mismatch in the documentation. The
> kernel-doc still refers to the old function name msm_dp_bridge_mode_valid,
> while the function was renamed to msm_dp_display_mode_valid.
> 
Will update it.
>> -enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
>> -					  const struct drm_display_info *info,
>> -					  const struct drm_display_mode *mode)
>> +enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>> +					       const struct drm_display_info *info,
>> +					       const struct drm_display_mode *mode)
> 
> [Severity: High]
> This is a pre-existing issue, but since these helpers are being exposed for
> MST bridge reuse, does it cause problems that the info parameter is ignored?
> 
> Inside msm_dp_display_mode_valid(), the code checks capabilities against
> dp->connector->display_info instead of using the provided info parameter:
> 
> 	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
> 	     msm_dp_display->panel->vsc_sdp_supported) ||
> 	     msm_dp_wide_bus_available(dp))
> 		mode_pclk_khz /= 2;
> 
> If this is used for an MST stream, won't this validate the mode against the
> main DP connector's capabilities rather than the specific MST sink's
> capabilities?
> 
When MST call it , will pass corresponding *info.
> [ ... ]
> 
>> @@ -1406,11 +1403,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>>   	return 0;
>>   }
>>   
>> -void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>> -				 struct drm_atomic_commit *state)
>> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
>> +				  struct drm_atomic_commit *state)
>>   {
>> -	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>> -	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
>>   	struct drm_crtc *crtc;
>>   	struct drm_crtc_state *crtc_state;
>>   	int rc = 0;
>> @@ -1419,7 +1414,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>>   	crtc = drm_atomic_get_new_crtc_for_encoder(state,
>> -						   drm_bridge->encoder);
>> +						   msm_dp_display->bridge->encoder);
> 
> [Severity: High]
> Will this hardcoded encoder lookup break MST support?
> 
> In an MST topology, each stream operates through its own distinct virtual
> drm_bridge and drm_encoder. By hardcoding msm_dp_display->bridge->encoder
> here, the primary DP encoder is used instead of the encoder for the specific
> bridge being updated.
> 
> If the primary encoder isn't participating in the MST stream's atomic commit,
> won't drm_atomic_get_new_crtc_for_encoder() return NULL and cause the
> helper to bail out silently without programming the mode?
> 
We will further refactor this in a follow-up patch series so that MST 
can use the corresponding APIs.
>>   	if (!crtc)
>>   		return;
>>   	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> 

