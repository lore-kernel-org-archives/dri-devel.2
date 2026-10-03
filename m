Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C66CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472E710E6F3;
	Sat,  3 Oct 2026 00:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmrw37eX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kCDY3Zxn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D468810E6F7
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:46:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Nf3aA2503360
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=; b=kmrw37eXy6VLn1HD
 URi+EdBB8WmglvmupkKmMxCWNA5OLkEKOXkvIXotgZYpg282D240xBs94RCdc974
 +VCcU4VejxVLmFMb706Aipp7a1A6uIlDbBrVoxWhdIJCQiPu4wi44Up4o7RtbIH1
 roFj5H2qYpGqftRQJQNhGCdlXloN3y1AgWD16cRofo3mtz3ayzwovEG2ujT7VM32
 Gi/BGSp1hSckfrJ3aYOnXmawmpWEur88eR0P3aZ5nbpwn3l2lzKPEo0HB/b0ZJNa
 /rPFjwIJIUPVgN70CjjHtLuQcb/9sHJ0Ce3TPGppM0SIL3uDGn6KMNISs1y1Jm7V
 lJN2WQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8st57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:46:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c58ee2116so27151285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988417; x=1791593217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=;
 b=kCDY3ZxnT7o+q/CfVSS5EPYRLSUvypoMrFP5yskBLnbvpJr3D/ZNZfy8T7F2divSBk
 QjDUCNKULDyn7hF8LXbMinYFp6WXlXNVdxeL0LDvW5p7b55IADh+IlIB5g0c9yd1/i8f
 e3pusegbaZn+1Ns1pjM2AdunZiR4sJo9ONAx46ZY39g66glHAGu6UtvMK0WSLhcysn5L
 1UOb+tVFXFx4xOAl+bu5TCxUTk5ujq+jXcxa7RcfPZWLPuIbnFtFVPP7DM2F1WLzywvZ
 48JG/rDcWp+/fuCU+rsYp/u7QMKhtYy+VkXXisvq2b7WQIap2UQSmfzv3BCuW8UThJxs
 3wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988417; x=1791593217;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=;
 b=DvKq74EBpboGxo8s/SmG6ceQlBJKX5Gr6oVX14KQG8uzZLFa0PfH9qk6GUvbN9N7lC
 nfLil9oThu6ngbaikFugpqkPxZzPeSgmOD0dGQP0rRoca0nsJZ5vMoGrFfOsaK3NW+nJ
 5LhN3bmjsiw7b4tZw6Qo1yT2MJ14sGSY18gNZVDWekjShOEssgHzH3hvTZpWpdobAR28
 M/ACRarGghy4kjngnvuwyM2deGb+Mq5nzI8lSCkGHlZ1BtDdiCmmYgg5y8TCwtWMOt9x
 CjnFVIYwlAOmJIYKdM9YvLn9MsIfAcF/YhuP6zoJuiIJwWOodBRBdjvu4+4pQ63fdHdl
 b7iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwG00YCK8i85cQGPf0G+yyNlENWIzObTFlBpoY2D2w2gO4cOCDkT7D5jNAurki421cu+vvKVodCEk8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mCdNElaFbznmCAl4q4essAzuOy0/Am7jdslyBgxPbZEzBD/GbD
 kIX5M/vC04i0sfmrba1Iwf/etqSlfoADExpWDiO+U3iDYPNSwP3Op/XUI9TdS16EoyX9/mS4GsS
 HO4UKscUPj3SiCddtMAEmoJkNHDGa1b6MAhPZEXDDLqC3pEw75je+Cboz9F3rCoPl8iWRmrU=
X-Gm-Gg: AYBFou1abSbHRAKn2dzHIN9qQa8OSwUJyGDDNUQjzPdtPc0CwT5LzcvjPdpXb+LfNJh
 1Wavns4WzVq77MuaXHbQiocYXsqNQFFkBpU0HGhyoWeoLTuZSX12R9lhj6UJZmykdtnSyU7Bqxb
 15FjByEZse+4ZdS/1RmA+7oiXFONEo29iNHWrQRFi4NaBX0bXizIl/s8HDqFTAFoVRJsFGcIahg
 1GaV/R94UlQNETN5MYBUpVai1Gft2DAw25CTaRZQiSOxAaOcGarhwxd0zrX1YUv/H1232exC2GW
 EC1auVxscIsrG78LRAc5UmWN+aaFx6u8tlmP/2qQlV/r+9Ik3Cv0of0s8XJGzi7cAigUZcROPdG
 8HT1Apj2IoVFQKwlHVTG32gY2ubwcYSQs4jf2WU8Boj6abCu4fUPFr8/fMIU5wVU5dW9eluhbdL
 NQAj0v57PEFxRM
X-Received: by 2002:a05:620a:a18d:10b0:93c:2946:5702 with SMTP id
 af79cd13be357-93cf1752323mr610229185a.39.1790988417088; 
 Fri, 02 Oct 2026 17:46:57 -0700 (PDT)
X-Received: by 2002:a05:620a:a18d:10b0:93c:2946:5702 with SMTP id
 af79cd13be357-93cf1752323mr610226585a.39.1790988416613; 
 Fri, 02 Oct 2026 17:46:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:46:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Sat,  3 Oct 2026 03:46:51 +0300
Message-ID: <179098834081.3641559.14344283439671349892.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8Ifzaxf3nZ4XolCC-wU49K-A49Fqh53w
X-Proofpoint-GUID: 8Ifzaxf3nZ4XolCC-wU49K-A49Fqh53w
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac05081 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=UAEniXUar9Pip7w0YYAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX4Du3q4D6vmfM
 iHAhBGxKk6X9HBlwqYL4lRQou7EtAXuE1BhaMfXJU1zGUil6F2D02rzNV4+d6wzowRjY8aQdmV8
 NNe7LiCLGsMpRN3Wp4670lcuk2I2wO8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfXy+En21ZdH5BF
 6K5Wxt/9+0h791qXWiCZh9nFUPPiln6kqlXmuuYGuEphEkVbEXpa3s+uPXucgWyzbdABTghP9zs
 lF6jpHB28hqhVuc4dG2L1yOOzEKobhbPkyBxw2JnucgHa3KkeXbfXJoIYiwKFHx7e+TmexxGGK2
 fqXncSLW0wxpgWriMn/RxsVt0Ic5v5bxg17xOQqP6KZMdc+G8ozcyQyvponstioOTq2rw1F3ejF
 YY0dewoL8uV7h+rSqEF+jrkzkkAlHHiK3yQsqv4RHUumU41MAXJVSS6GrRtrEbM200KxORIueST
 VZ5H6qTmqMpsbThyorWnzCtHPqU9xLcRCKpCSlyTPq9dyBQA4NtznVgpRlXIcRB7EcAno56+Sm5
 Jl17kglUcURFFVvFG4tDNZk3xzbs2ccByzCsFPR1SCroM8YPEMxhBm5/Q6qu8KFfROZXzLVhDjc
 bxET42qp0wp/PaxDqug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Fri, 11 Sep 2026 12:29:33 +0200, Krzysztof Kozlowski wrote:
> Changes in v4:
> - Fix second name in "Properly handle msm_ioremap() without name"
> - Tags
> - Link to v3: https://patch.msgid.link/20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com
> 
> Changes in v3:
> - Add missing regulator_bulk_disable() in msm_hdmi_phy_resource_enable()
> - Set hdmi->power_off=false before calling msm_hdmi_audio_update()
> - Link to v2: https://patch.msgid.link/20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com
> 
> [...]

Applied to ttt, thanks!

[1/7] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d27f831aaf20
[2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/dd6ecace5785
[3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0499f0576e44
[4/7] drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/07bd8f9379c2
[5/7] drm/msm: Properly handle msm_ioremap() without name
      https://gitlab.freedesktop.org/lumag/msm/-/commit/14fe0ea79e0e
[6/7] drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8b7a90dbdfb1
[7/7] dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3309f5c88860

Best regards,
-- 
With best wishes
Dmitry


