Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D4C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B8310E34D;
	Wed, 16 Sep 2026 06:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJfHApqx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R8zU+xyj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64A510E341
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:41:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G69dlj1163427
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k7xUpNbQ+GJk0CbZTwlsOmUvv3akuhf1PsrESAkkrMs=; b=oJfHApqxG2uOt3Z1
 V/TbV0YFH7lnDjG919dTQbFfcYoLKOE8u3pPql4rhrsTjRaF09Wb8KwERtMtkfpG
 STJbqBZGSA2W//Cy6Ran8ODglVH4MoGMUAJLZs17TO0uZc0iwaUSMtkow5a4Adey
 auiqFcJXeBvcf5TLhkC9im8+cNoF/wNVHT/+TaF6q5HVQbpTS4Y27mFbYOQl/o0/
 JrvBoAbpQ1f0Hk1LV0ZFEiHnXfel2rHT/sXQx2tdSFyTh2nbEIuwFiK6IMsMg+DS
 Gd7VuW8pD0HEO8LUkpzsYyTye5w3PeY1N8m4yeBADlxUiTUs8E0WHTtwNZQP8YBV
 mqQN/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n63769-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:41:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a3f673221so286760185a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789540895; x=1790145695;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k7xUpNbQ+GJk0CbZTwlsOmUvv3akuhf1PsrESAkkrMs=;
 b=R8zU+xyj9odv/xIk35R2kZ+9BQ1laBJKsXYTtJ2BvJwlYMu6heYC+WX6+l7s39kt/6
 P1CrTkTaRSi5aQ9y5W4hX6A/2zN7T+dopXsiL+RlYoLwdxBQwgqnUkBoQsZCexNTibdO
 niZ39PTfsoPRjC/Oo8WsHCkkGN7UfGLK1mxF7dTczZDUef+/rej9QDSfvhAjv8WHjeVI
 P6D7B99fksb7Ex22+VTlYn29TpK6FXe3ewd7k+bCgYE+YDBu0nAekg1pBUgtmmlNWvZG
 ykWjUHhi4vFuPHQFE3Z2K2dA0MZsXVQxWlRlJnrr5zV5slNY1TLp/4+ExvWr7TR36PLj
 RfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789540895; x=1790145695;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k7xUpNbQ+GJk0CbZTwlsOmUvv3akuhf1PsrESAkkrMs=;
 b=vt38uZwfYPqOVi9zta56mYhlBQKGDPadeDCd94KBKDAedAWKIW18kTMinSBKGHA1Xq
 5pacpbWr0nrDRUaO79bv01XznV6KRgUhGkOEehVq7w32ueqYOHFTXTi3Of+LT17yersg
 wpoCoioS2pp3l5K8LVFT6TSWle96X5F3iFW853sJDRHYfBruCNb4hT2wQHmZ+C1lr1z7
 1X2QKGsYl5qx89XdAoLDKvmu0OKslIM7Cd624pv4Ih0aZwqeTshdewBXCyo5b/9IFz1l
 SaldxAshpZUDj/dYoiCENUnsP4XKphraw4td3hoV6ckKpnv60ljD8baqE95fSC+culta
 Xecw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZB2Ns/4dVRnN8CNW6kiyj8C7gixXVRiHZn4E8ugWNGVWR3WZN8x7b5cDijbId8gezTPRYWezfGKw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kw4uDSI7yGQN85ZHda5kOMs+1L9q/VKPoYhOmhIAitiYnSlFkS
 A3gImxOmQrGhGIMqb0/y6alcTXJO3KVFb12/UIZGyRKd9nHryAnfyjqdF3tlwlENmgSKzkOhHb4
 g+uhEQZzEfBEp3quvkrwFC03cUUl9W2QC+pA0e568dk761GYmB2k5k5C4l1i8YlydKDbD6Y8=
X-Gm-Gg: AYBFou1Sz/DTC2x7I2/+Pv+zstdImPPiIPzSVcZdPXjebnV+sGvVHeWH5mQSc0khNRT
 MWftcgH1pN/hqp5XIeYyrtx2WCvqECaJjTGAGzEiM5PfgvthQ9tJ7oD7EU+qyC36Bq7li0HwbTX
 xIQYxz2H/5c4ejZYu/7llXErGNWG4Oz7WMDBhf9yFz5jXQoYZmly7diKRZUkPiVUDghT1HQDIIc
 CxdGjfjVW6qNuSndWc9lOFGsYRM4PLbhIpwxJzJh2/sHgBn+M/bYoNw6dH45CkQ0xdG9zNYaogr
 6+vV/0w5vsbMkQ9vn4NzLacjRe2HdRj5VU2dBxeH7lsqLkCt9fsAMlzsPDMrhq8ShV+iSqlNAva
 rZ40sx9eGlOoXd3CnFkk+KlvxyzkxAgb9RMLH8mGSyZEJAh3qenDrPws8DfZ21mVX
X-Received: by 2002:a05:622a:313:b0:530:ce8c:b6ee with SMTP id
 d75a77b69052e-5327f247e18mr24291761cf.60.1789540894449; 
 Tue, 15 Sep 2026 23:41:34 -0700 (PDT)
X-Received: by 2002:a05:622a:313:b0:530:ce8c:b6ee with SMTP id
 d75a77b69052e-5327f247e18mr24291481cf.60.1789540894012; 
 Tue, 15 Sep 2026 23:41:34 -0700 (PDT)
Received: from [10.38.246.144] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bef592esm17733656d6.49.2026.09.15.23.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 23:41:33 -0700 (PDT)
Message-ID: <73ab2465-5b11-4ca3-9a82-bf01bf9978e9@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:41:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/29] drm/msm/dp: Add MST support for MSM chipsets
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa3a20 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=7-eTeZkr4q0XwLXdS2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA4NCBTYWx0ZWRfXw5I6D8XCKCkE
 5r8/xE6KmPW0J3NP9Awg6KVe+5NcGJFUrmMD2hxSKB1RLS7wtt6qSPDEt320zD0i7r3rnHzDoic
 GB2zZiNIDHxZ32/NZqxRwiCVm8YFrf6Zq4zakPMada7YaFLP6uqe+FrWjY0TVlbD2Q+dGCntlTP
 XaFQabP0bJUUpq+KVdB/tVwiKqFhT5BAstvSQRJh19rZtM5cl3cP9H/W5A3vjBAjdSnbom0MEIs
 gm3iY1ymgApk4G3PbEWqBhIsGpLNuKC5FUgoIt2g+A7YoxAuOoEUgpXAX/64LGk0Wr7WuMqYjYF
 ICuHVK3Gm5xs/DBU7+4Egg/4H6a4VqnOX53w2orkHRecyiPFZnJDFVm++kASXNGi9pQXIS5jqFz
 IpwTSXELW+Zq6e8EycKR8lyB2KSlma+JKcrzhsToYwE1l60duKM+qUMwY66YyJG0o7Fks/jiET6
 Vu9p+9UzC0NO/sPWvnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA4NCBTYWx0ZWRfX830G3oJSKdPP
 UulFhxUTjGUZV2DBs0iq18gtg2FAVZoj5arPvsyrzeg6cijds8+3Zag0dih6PdqkU32me2AmQwM
 GGo3zhoRnD8E/TdRtFqG/RBEr4omUUU=
X-Proofpoint-GUID: 9fB_kYbd9vrHyJHHLgl_dobzA5IxUCPV
X-Proofpoint-ORIG-GUID: 9fB_kYbd9vrHyJHHLgl_dobzA5IxUCPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160084
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



On 8/31/2026 4:17 PM, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.
> 
> This series has been validated on sa8775p ride platform using multiple
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> 
> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.
> 
> In addition, SST was re-validated with all these changes to ensure there
> were no regressions.
> 
> The prerequisite cleanup series [1] has been merged into linux-next.
> 
> Type-C MST support depends on the DRM IRQ design which is still under
> discussion, so it will be updated in that series first and folded into
> the MST series once the design stabilizes.
> 
> Overall, the patch series has been organized in the following way:
> 
> 1) First set are preparatory refactors to decouple link-level and
> stream-level operations for MST readiness.
> 2) Prepare the DP driver to get ready to handle multiple streams. This
> is the bulk of the work as current DP driver design had to be adjusted
> to make this happen.
> 3) Finally, new files to handle MST related operations, DPU encoder
> integration, and SST/MST connector state management.
> 
> Note:
> Validation for this series has so far been done on the latest linux-next
> on LeMans, covering both FB console and Weston.
> 
> [1] https://lore.kernel.org/r/20260528-dp_mstclean-v9-0-f094cea8ca24@oss.qualcomm.com
> 
> ---
> Changes in v6:
> - Rebased onto linux-next 20260828; drop already-merged prerequisite
>    cleanup patches.
> - Reordered patches for better logical flow.
> - Patch 01: Also move power_on=false into display_unprepare.
> - Patch 02 (new): Split from old patch 04.
> - Patch 03 (new): Split from old patch 04.
> - Patch 04: Squash num_pixel_clks into this patch.
> - Patch 05: Use loop for snapshot; skip inactive streams before adding.
> - Patch 06 (new): Split register definitions out of old patch 04.
> - Patch 07: Rewrite old patch 04; replace stream_id special-casing
>    with transparent msm_dp_read/write_link() helpers.
> - Patch 08: Fix REG_DP_MST_ACT register placement.
> - Patch 13: Drop defensive start_slot bounds check; rename
>    channel_alloc -> update_timeslot.
> - Patch 14: Guard link training with active_stream_cnt == 0.
> - Patch 16: Add locking annotation; group link_ready with status
>    variables.
> - Patch 17: Drop redundant stream_id >= DP_STREAM_MAX check.
> - Patch 18: Consolidate msm_dp_mst_attach_encoder() and
>    msm_dp_get_mst_max_stream() definition, declaration, and usage
>    into this patch.
> - Patch 19 (new): Split connector/topology callbacks out of old
>    patch 23+24.
> - Patch 20 (new): Split dpu_encoder_get_intf() refactor out of old
>    patch 21.
> - Patch 21: Squash stream_id condition; reorder before MST encoder
>    patch.
> - Patch 22: Use thin wrappers instead of renaming/exporting core
>    dpu_encoder functions; use suggested for-loop style.
> - Patch 23 (new): Split atomic stream enable/disable/check out of
>    old patch 23.
> - Patch 24: Add hpd_irq_lock; use %*ph for ESI debug prints.
> - Patch 26: Defer SST-disconnect-on-MST-cap to new patches 28-29
>    to avoid bisect breakage.
> - Patch 27: Add comment for clear-before-write DPCD sequence.
> - Patch 28 (new): Split from old patch 14; handle boot-with-cable
>    SST bridge detection.
> - Patch 29 (new): Handle SST connector status when MST is enabled.
> - Link to v5: https://lore.kernel.org/r/20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com
> 
> Changes in v5(fix comments from V4):
> - Dropped early refactoring patches (v4 01-12); restructured as
>    "move link-level teardown", "factor out _helper variants", etc.
> - Dropped v4 39/39 (platform MST stream list); use DT pixel-clock
>    count instead per Dmitry's request.
> - Patch 02: Remove artificial max-stream limitation check.
>    unify register naming (REG_DP1 vs MMSS_DP1).
> - Patch 05: Calculate ACT wait time dynamically from mode parameters
>    instead of hardcoded 20 ms.
> - Patch 08: Replace start-slot loop with direct math; fix commit message.
> - Patch 09: Add locking annotation "Must be called with
>    msm_dp_mst::mst_lock held" to msm_dp_ctrl_push_vcpf().
> - Patch 17: Rename prepared flag to link_ready.
> - Patch 22: Move drm_dp_mst_atomic_check() call into msm_atomic.c.
> - Patch 23: Replace bridge-based MST DRM model with encoder-based
>    approach; remove redundant bridge layer between encoder and connector.
> - Patch 24: Add drm_edid_free(); add FIXME for bpp negotiation.
> - Patch 25: Use dp->plugged flag instead of link status for MST plug path routing.
> - Link to v4: https://lore.kernel.org/r/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com
> 
> Changes in v4:
> - Fixed most comments from V3.
> - Rebase onto HPD refactor V5.
> - Fixed casing/formatting issues, for example: “mst”.
> - Drop .mode_set() and set_mode in .atomic_enable().
> - Rewrite commit messages that are unclear.
> - Use the same API for MST link and SST link writes.
> - Use the new drm_dp_dpcd_read_byte() / drm_dp_dpcd_write_byte() interfaces.
> - Remove some unnecessary payload fields from the MST bridge.
> - Remove some defensive NULL pointer checks.
> - Reworked the patch order to make the series easier to follow.
> - Add support for more platforms.
> - Link to v3: https://lore.kernel.org/r/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com
> 
> Changes in v3: Fixed review comments from Dmitry
> - Fixed lots of comments from series V1/V2.
> - Rebased onto next-20250808.
> - Rebased onto Jessica's HPD-refactor branch.
> - Fixed formatting issues in commit messages under changes.
> - Removed unnecessary one-line wrappers.
> - Relocated MST-related .atomic_check() calls to their appropriate positions.
> - Removed the logic related to slot checking in .mode_valid().
> - Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com
> 
> Changes in v2: Fixed review comments from Dmitry
> - Rebase on top of next-20250606
> - Add all 4 streams pixel clks support and MST2/MST3 Link clk support
> - Address the formatting issues mentioned in the review comments
> - Drop the cache of msm_dp_panel->drm_edid cached
> - Remove the one-line wrapper funtion and redundant conditional check
> - Fixed the commit messgae descriptions of some patches
> - Reordered the patches and renamed some functions and variables
> - Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
> 8618d42a99a@quicinc.com/
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> ---
> Abhinav Kumar (16):
>        drm/msm/dp: move link-level teardown from display_disable to display_unprepare
>        drm/msm/dp: introduce stream_id for each DP panel
>        drm/msm/dp: add support for programming p1/p2/p3 register blocks
>        drm/msm/dp: add support to send ACT packets for MST
>        drm/msm/dp: add support to enable MST in mainlink control
>        drm/msm/dp: no need to update tu calculation for mst
>        drm/msm/dp: always program MST_FIFO_CONSTANT_FILL for MST use cases
>        drm/msm/dp: add support for sending VCPF packets in DP controller
>        drm/msm/dp: add support for MST channel slot allocation
>        drm/msm/dp: replace power_on with active_stream_cnt
>        drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
>        drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
>        drm/msm/dp: add HPD callback for dp MST
>        drm/msm/dp: mark the SST bridge disconnected when mst is active
>        drm/msm/dp: enable MST on capable sinks
>        drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is present
> 
> Yongxing Mou (13):
>        drm/msm/dp: refactor msm_dp_ctrl_config_msa() to take panel
>        drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
>        drm/msm/dp: add MST stream register definitions
>        drm/msm/dp: add stream-aware link register accessors
>        drm/msm/dp: add link_ready to manage link-level operations
>        drm/msm/dp: introduce dp_mst_drm module
>        drm/msm/dp: add MST connector creation and topology callbacks
>        drm/msm/dpu: pass msm_display_info to dpu_encoder_get_intf()
>        drm/msm/dpu: use stream_id to select MST interfaces
>        drm/msm/dpu: add per-stream MST encoders
>        drm/msm/dp: add atomic stream handling for MST
>        drm/msm/dp: wire MST helpers into atomic check and commit paths
>        drm/msm/dp: mark the SST connector disconnected when MST is enabled
> 
>   drivers/gpu/drm/msm/Makefile                |   3 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  51 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  27 +-
>   drivers/gpu/drm/msm/dp/dp_audio.c           |   2 +-
>   drivers/gpu/drm/msm/dp/dp_ctrl.c            | 479 ++++++++++++++++++++++---
>   drivers/gpu/drm/msm/dp/dp_ctrl.h            |  19 +-
>   drivers/gpu/drm/msm/dp/dp_display.c         | 414 ++++++++++++++++-----
>   drivers/gpu/drm/msm/dp/dp_display.h         |  26 +-
>   drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 538 ++++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  16 +
>   drivers/gpu/drm/msm/dp/dp_panel.c           | 205 ++++++++---
>   drivers/gpu/drm/msm/dp/dp_panel.h           |  19 +-
>   drivers/gpu/drm/msm/dp/dp_reg.h             |  69 ++++
>   drivers/gpu/drm/msm/msm_atomic.c            |  14 +-
>   drivers/gpu/drm/msm/msm_drv.h               |  41 +++
>   drivers/gpu/drm/msm/msm_kms.c               |   1 +
>   17 files changed, 1727 insertions(+), 199 deletions(-)
> ---
> base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
> change-id: 20260410-msm-dp-mst-35130b6e8b84
> 
> Best regards,
Hi,
This is a gentle ping on this series.
If you have a chance to review it, I'd appreciate any comments and feedback.
