Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908A8606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dJK3jnfQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IBbfZeiw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C71112A71;
	Fri, 27 Nov 2026 11:54:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F25112A71
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:54:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARApI3l273454
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jOb3V4s7GJf/HR8izcqd+kAE
 DQnH+4Otpm3L4J95xHI=; b=dJK3jnfQaGWKJX8QOPDGefiFFSusT1SYTSKJ5OHW
 OYl3DCnYWNVhy9EOmXFJLCdv8T7a8IRMFUhMrYcX9RyjRY39MXbLFVTh3ieeQ1oF
 +LVDE6a3hj5nTBJi7pBnHssZzHheidImR6x+xvZjtV8yJAU9J1chRZ9arDxcC7IW
 rTDhr/98OYT5PmnqYMOaKUSb6JcmJb7ouXYqMhm7E84Br6K0FWvBzrNNArcynm7h
 MPfDtNomKvDmu6I7h+UCxmaiOVrd7Bhizlsi2JTsW3zXB8ng0q/8hhltQ8wF72Dy
 Vtv9G8Mm/LYysGMnpe/gOTx5LkpvBbKlcJYWbzaDNPPuWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49auw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:54:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9496ff065bcso1074026685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795780470; x=1796385270;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jOb3V4s7GJf/HR8izcqd+kAEDQnH+4Otpm3L4J95xHI=;
 b=IBbfZeiwk/TN74kqFTPe5i8I8krFmlksPgEuj3CMlj3QzLh3uk9rHB1CTmWvZLuNZ1
 M6sHayKMmtSA8MUxpdUW652B87xvfwlpXbcGzcvZw/uHCLAWP2YSOhYF0d4vi4am47jz
 olMbL/SqPrPRjKJhu+hLzwsM6Yz9Fbu4wwKXnjO2NoykaLrfUw7eJTQIEbg0lYKM8dkP
 uPzvl5EBKTcJlt10yw29K+0Pq1f9NrddnUeMt+Y3KeUheYtYdrIU/Dm2wUoBuUkOCdP7
 kFHK1RHnSgC/tGgJYJQ3w0akItKlz8ABpG8lWdPWWb5EHD68Dgf0wLk9x7JWYGlueQwE
 d4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780470; x=1796385270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jOb3V4s7GJf/HR8izcqd+kAEDQnH+4Otpm3L4J95xHI=;
 b=BpfIEx0zmzhml27et7Ls0+Lp9Za+fuqB6ybicLERBBv9mYpyDaCa9y7Cvw55vkcNvT
 Sq6PNCSxYOFRPYiwQNibWfRLBftsUSxRzuoBKFr6o9ko5oVrr/2qbHHYmpNGe14LWM7b
 ouqmtGu5VbT+4362dCXHjK2GhcVLf4qKXZaiR8pNwlAOGjH5Tz2QsvuyWdzJjtSEZw4u
 5myJf2zLEgHatx0db+812WbT3dlS1tZJO2L3BSYgjT9soIiXna3w5CXDZgyRngqCSYot
 AQLHUpgUSXkXMTX3azY8fWRLYVCewkDteru3cIAtn2yR144aI0hEX26XcHypJ/U5zO+T
 Ki/A==
X-Forwarded-Encrypted: i=1;
 AL+hErGRh9jrWtv3jn9o3pDIGBCArHst1j6Don8vEBEZzfJ3excVYk/emiWcEzbZp+/mEjumhR68WUta66s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+7dKT22Eq0n629RKbeq8VaD4Pmt4HftOdMoQqA+NI0ehLqTA7h
 OzvmIP9PrI8cffJ2p85G4KSPS0sDWXR68X1qMI0E5QInb1LMGckgZ/m+lFSUlkCNy7XfddysHlc
 Cu929sps+Onbp1MKLUWvfaQOOXiLeeoQvyEc48C8QrIPtkyxpfbmGk4E6eUnPwlg1EMD0HhqSR6
 1FyLV1bg==
X-Gm-Gg: AZFdTZceguvWvGsC7Xiywq8mLpJ1YG3Xew409Q1BElGSUvcdapzOdoVYOE90O3kIc9B
 V/4jgAdHWVdKJ8FlOPaO3DxC314KBlIiL829JUqX0pfElK1jgQQ1bqlWA1bF3/WK2ozmtLRqt7z
 OmWnX9sUnhRGoaCB375QcCpaINAW6nU8TTV+BLBZDTQZlgQHqSkfyi4x2MYu0AWLWuMLF+MBFKo
 OkTfw2fTOViUXt8ktvC5t3UP7LsM4CrWAvCd9oi3XOIbqJWbh47gqAkPfofO1/Ju8/n+6C9UfBb
 GgmSJyhRS3NWtQv4Ps0BOJL3mY3taG4BtaFhcUB/+SfX84sJhpzGPWUo0JU+I2otgnid+pHXADX
 Ms6hY+CO67JUUjouO2vrPyKeZCxhwjBT0jkkCtuJ2/pvk58ildhDXJJfSQtKnZk97hVZAvgSJSf
 5DZf7x7zPOX2FnwtMRUwYyPiyFtTrMjAOXW8Ts9lqpAhlUiqabXuk3yrbwPtCKWw==
X-Received: by 2002:a05:620a:8001:b0:93f:2aa8:c555 with SMTP id
 af79cd13be357-949ba9fdb81mr3886111685a.57.1795780469685; 
 Fri, 27 Nov 2026 03:54:29 -0800 (PST)
X-Received: by 2002:a05:620a:8001:b0:93f:2aa8:c555 with SMTP id
 af79cd13be357-949ba9fdb81mr3886107385a.57.1795780469175; 
 Fri, 27 Nov 2026 03:54:29 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcff8ba4sm6010373e87.15.2026.11.27.03.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:54:27 -0800 (PST)
Date: Fri, 27 Nov 2026 13:54:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Saim Shujah <saimzst@gmail.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/msm/dp: don't log an expected link-training
 fallback as errors
Message-ID: <5pav6gzpp73wqwyewygyko3aj4lhy7jzcwzwfb7ro267xjmzib@drwkmrcselc2>
References: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
 <20261005131432.22840-3-jean-francois.bobier@laposte.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005131432.22840-3-jean-francois.bobier@laposte.net>
X-Proofpoint-GUID: EDplbWLRm9ict3c75xfTkmuPjlt9Vt9T
X-Proofpoint-ORIG-GUID: EDplbWLRm9ict3c75xfTkmuPjlt9Vt9T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX9w4A1bYthRZM
 5Ue+3KMZT5K3BPbxbMUDFpGN99X52Jw843+BruGPtvCVPWj+dOkB4KhLKejnha4pIg2Vz1ZnoR/
 aQ70s+mnc0YyH4g1EfhqRQu8QYIjkVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX0Pf7zyx2PaGl
 d7kw+Zh5HP3JajvvuPLWDTIp1kuhW1UobEQjfZCptdaFQF4gGhSyD1H5OC+jsLtq/1fi8Kj6xOo
 Fw5C3c1UU9W3sAS/5SmduCGAGd1CHRqCuup4ad9/oD+bil8Y86uBdwfzGrvrgumcHq08HCFt1Sg
 Y3FumlJCFlbUnrkJGbMMgj2X2q0LN1hu+pCtWdHFE4byBUQUSjlAB9XjNJiFWA1jtpKhEdw2WYR
 aqwzzf0QL2uwoIWaoaFT/TB0rzVl5Pfxj3LcrIYwbuTODqufhm+W0QeUCXA8bYIMSOVZMNXB9Sw
 8DmzTnmwJFdJCyIVIlsYckdzbSnqUVlmqYkuOXYRk5kdyAW1t53Y+KXaZLv1vfSqRxA828D5x0G
 QVmJZsWmRaI2DYXJ6OKSn4mTndQR70otvqSixHu8SwFSaD6hAl5AzrEn3BsYJYjG3sRnCGH+DAi
 Pp19AawnRofe3pAuWOw==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b096f76 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=AVbMHacnAAAA:8
 a=EUspDBNiAAAA:8 a=-PfVqtTFaXArj6z4HRoA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Z8w8RPyABVWp4NBWd0ke:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270047
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 03:14:31PM +0200, Jean-Francois Bobier wrote:
> msm_dp_ctrl_on_link() implements DP link fallback: it retries
> msm_dp_ctrl_setup_main_link() up to five times, stepping the link rate
> down HBR3 -> HBR2 -> HBR -> RBR and then reducing the lane count, and
> breaks as soon as training succeeds. Every step of that search is
> therefore expected to fail before the one that works.
> 
> Each failed attempt currently logs at error level, from four places:
> 
>   max v_level reached
>   link training #1 on phy %d failed. ret=%d
>   link training #2 on phy %d failed. ret=%d
>   link training on sink failed. ret=%d
> 
> A monitor that settles on two lanes after three attempts prints nine
> error lines on a completely successful attach -- which is how a cable
> that merely has two bad lanes looks identical in the log to a sink that
> never trains at all.
> 
> Nothing is lost by demoting them. When the retry loop really does
> exhaust itself, msm_dp_ctrl_on_link() returns the error and
> msm_dp_display_process_hpd_high() already reports it once, at error
> level, as "Failed link training (rc=%d)" -- which is the correct place,
> because it is the only one that knows the search is over.
> 
> Demote the per-attempt messages to drm_dbg_dp() so they remain available
> with drm.debug, and keep the final verdict where it is.
> 
> Also demote the unsolicited AUX interrupt message. msm_dp_aux_isr()
> returns IRQ_NONE when no AUX transaction is outstanding, which is the
> whole of the correct response for an interrupt that is not ours -- the
> AUX block shares its interrupt and sinks raise AUX status asynchronously
> around hotplug, so this fires twice on a normal DisplayPort attach.
> 
> Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c  |  9 ++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 15 ++++++++++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
