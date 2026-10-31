Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFE606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CLUZaKpj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zf0xsWnK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE6010E009;
	Sat, 31 Oct 2026 20:24:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC5A10E009
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:24:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJEweT2968905
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LC+7yPvVyik4+Gpd7nEEb6EX
 AVPzoW8RCDIH4uELTVY=; b=CLUZaKpj1g6ex8FCQS9pJcuDpv4TWX1jzc6/jDUi
 FcLRQVpCsXqEfFD4fRBfDD4ODU/Ls5M2UzJGJ5KmxZ7JYmAFXz6jhMj0ENhwbR6A
 B1wTUC9uKrcyTHYnr2p8RYfIrKzgHEWmqfz12f/SP50gazjlgL+oSHB/0HmWYvyS
 BNa1+kPp5hHvOxoA1BQoBbGpfFW/iBmiPgNh5rUTJqRU42gLE9D3zM8+FtK2xoBA
 m97fzzVV3pr1pnS43kNzkBLSgLEjdqKNVb3NaIzm8CFWKKbjf8lviSrUn8AIqUVa
 h5Dx2ZQNsSDS6BskLCATvsxGPLwMED3x5BtFDHgueQXGaA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkjd3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:24:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a2035a4so61059206d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793478274; x=1794083074;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LC+7yPvVyik4+Gpd7nEEb6EXAVPzoW8RCDIH4uELTVY=;
 b=Zf0xsWnKQnM1mk5+TX6TkBmnNghyG75JsNZWSs6iFkpIyblveEcnuS2uWlnjQX6QGO
 4MoBDXtwdJLbpPGMVUmgHF2u6jpZ6AX1+obnbDr5493hkD80rlO2gz3WqNrjc3k8oTQe
 tcsHg7tHBQiMqiKzAnqJPKsMoRDb+oEH3E/GPP483siHRJROImCd2W13sghIrTBy9r6R
 pMkoM544Rd0PrLZ9DaMwPtdfz0UwaNMTUVGOBap9jvSa2FEem8f06US1ilkaztIKLaBa
 4PrKSbVVEEhB4ebdNfWrQDSU5RGxdGP7gYuWQXAqbyAbDbItWGTgJoKNBFGYvaH9JUva
 eBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793478274; x=1794083074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LC+7yPvVyik4+Gpd7nEEb6EXAVPzoW8RCDIH4uELTVY=;
 b=kmrufKjcS0GqPtSaBH2+aJO1QeHA/GDzacWl6d6vyTRoXmlxzpcC25V5JQGpEvPUar
 nd/H9OV9r+7Do5dcmx5XHPbCUA5kXcxkQ3JDYOcj1VZNaGv/CZMmw7IyDI97DPkIrJdJ
 8fRDYGELPp/nT0vUcDa0MPLOFbYVp+uGinV6Yn11a+VAOAgUsrU3IFmOTectTmtq8F+o
 3TUmooQVKzo5Ghuzmpi7rRR6sCga1aQNS50CzvqyR9R6cKDA+qmSCXS4Z4rOWKy8Ls6T
 9THi42wr7RzQApC5qSdbOgjmpe+wn9vUPLZroJ2mMcZK5XFa37JOQaldLQLQtBapnEte
 fU7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsxjVBODdqCygskNRCKFQSvheVfSq2GNla3jC9I4OMWajy3lVr0x+mac9yHLnjbKpzcGlxE4Xv8iM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLP+wRyhStHGTS1Tq+Je9/+llqrDG4xnqs6LnGrco5FCwqN94cJ
 LU31Jyrlf3JReyZf1aGaDEnPJdCtiItwtQ56J2Spms6aVjnj20ikibCVdZMpJzVT2E7GU/YEM3h
 ghLp1Am1lwVuvjo/s439TA4y8oqINh6/LcJrQgFvEtHt/erAqCfMFJBkx21nvKlxM21tJVNk=
X-Gm-Gg: AYBFou3DAEZrVkHQ4dhNlCLz8wPCJPBxpXm+vVfKUxbYTXV7tJ22V6hTDbPEF92Slnc
 v4OOv/3ut4FXtqkxqZsNA/EUq5lKXsTwSq7J7M0uZ7Kso9CS+6dk64bTqHXYKdjV+fqYj4LTB78
 Gu5HXyKYxnHor8kpu20TwPfFwz/ZdWsVBq8Gwal9xkwUEgZ7dJhcE6Ad4ylHy8xV9lZPbBsxZQB
 lfLJbm9Nk0eVTlzv9WgYD+b/Q/7nvSVajRWxaxvOV1kcGc7rEkA7JhpOo8sOsTsu7+/It8ebOIM
 2Vr16zJy5KnW+VAXd/UmcTEGb9j8c8R3NE755S94/poPPKrilHsZGqI09ie9xcHWCUj9TZTDuXh
 7cs6Q0LZavWdUMLWTG++gHVjNWa3qLnlvrrJZvgybeS4IpX5ehAmFLh4EjhfIVbTqfXl9lbdoRb
 QmUMocx9Uhh0XgBLjezFF2Bqat2DapUgDS7zZH7Fs/VumTvhGYvHxoNFMIqpUc8A==
X-Received: by 2002:a05:620a:444d:b0:93f:4498:603a with SMTP id
 af79cd13be357-944133d4a68mr1436455485a.35.1793478273694; 
 Sat, 31 Oct 2026 13:24:33 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:93f:4498:603a with SMTP id
 af79cd13be357-944133d4a68mr1436453685a.35.1793478273159; 
 Sat, 31 Oct 2026 13:24:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acbbefd30asm13000291fa.23.2026.10.31.13.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:24:32 -0700 (PDT)
Date: Sat, 31 Oct 2026 22:24:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/msm/dsi: move bonded command failure flag into
 dsi manager state
Message-ID: <l2pcxlml5vdv4ws75wvqjhxbjr43hfosrvd2nyewhup5umxu34@feozzmxb7poz>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261031150305.1107572-2-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031150305.1107572-2-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-GUID: Z4nUABPpOPdRepgMzXWb1k70IsRsZjwm
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae64e82 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=zRbll8i6zLBPDSgtwMIA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfXx9a11L4b7Lby
 Ju+5wgdfV+fYdy9CjfgIbT3Bs0H0odDMcXBiEtd9eMT8iuAQGC8Zdl6ooT3yrQnik5Xu30Pwiph
 uvKy3DENjuBXEpoXBjCrqlB/9mJrAS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX3GJM547twwME
 jUgADQq6PRjnUfWR+j1xon2TDTzk551dI0wqGjTUOZ67ij0X9RKGQ51cDT2+4IwMISCIKkanm+B
 Rp8Y5LelRpyrRZWa1KnfaopJtST1VoB+W7i7omyrHERzKyA3uDgnpyRyjrhavwuxHLLZkMj7tvh
 U2GWYF4byF6YWfsAGFDELjXD6RKMKbBqztTA5wxOeXSCdXIEip5UcWWvhlspEslgyMemDCKPNRd
 mC2KktWeSTcxiTQifYPXuOdu9AainwTd0Rs5ea/aJytZyTgQp0+ssnM1VR5BdItq/PDa2HvprTj
 25C91rCOAAt+O4YpYlSyh/S3uziej6HLkMjZt9k6Xog04pzYP+lGEOvTDHnyzrNZ9x0F3G2X3Tf
 dXG9YgnQDCJgl1bBt/u82F5hbLj+RO38jFzcyp4eN1h1l6cwmHy/KfA2rfWYhGX+7UnL6a7KryV
 KIqvSz2hTIDHK4mIlig==
X-Proofpoint-ORIG-GUID: Z4nUABPpOPdRepgMzXWb1k70IsRsZjwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310081
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

On Sat, Oct 31, 2026 at 11:03:01PM +0800, Qianhui Xu wrote:
> The bonded-DSI command path kept a file-scoped `static bool
> dsi_bonded_cmd_failed` next to the global manager instance, so bonded
> state was split across two storage classes. Move the flag into
> struct msm_dsi_manager (msm_dsim_glb) so the manager owns all of it and
> nothing mutable stays file-scoped. READ_ONCE/WRITE_ONCE use is unchanged,
> so behaviour is identical.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 559c07a8b9..93d636220b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -30,6 +30,7 @@ struct msm_dsi_manager {
>  	bool is_bonded_dsi;
>  	bool is_sync_needed;
>  	bool is_sm8750;
> +	bool bonded_cmd_failed;
>  	int master_dsi_link_id;
>  };
>  
> @@ -37,8 +38,10 @@ static struct msm_dsi_manager msm_dsim_glb = {
>  	.master_dsi_link_id = -1,
>  };
>  
> +/* Serialises bonded command transactions; the failure flag it guards lives in
> + * msm_dsim_glb so no bonded state is file-scoped.
> + */

If all fields guarded by this lock are held in another place, then the
lock should also go. Nit: please check the recommended form for the
block comment.

>  static DEFINE_MUTEX(dsi_bonded_cmd_lock);

Hmm what is your base kernel? I don't see these definitions.

> -static bool dsi_bonded_cmd_failed;
>  
>  #define IS_BONDED_DSI()		(msm_dsim_glb.is_bonded_dsi)
>  #define IS_SYNC_NEEDED()	(msm_dsim_glb.is_sync_needed)
> @@ -51,7 +54,8 @@ static bool dsi_mgr_uses_bonded_cmd(void)
>  
>  bool msm_dsi_manager_cmd_failed(void)
>  {
> -	return dsi_mgr_uses_bonded_cmd() && READ_ONCE(dsi_bonded_cmd_failed);
> +	return dsi_mgr_uses_bonded_cmd() &&
> +	       READ_ONCE(msm_dsim_glb.bonded_cmd_failed);
>  }
>  
>  static inline struct msm_dsi *dsi_mgr_get_dsi(int id)
> @@ -374,7 +378,7 @@ static void dsi_mgr_bridge_enable(struct drm_bridge *bridge,
>  	if (!panel->prepared) {
>  		dev_err(&msm_dsi->pdev->dev,
>  			"panel is not prepared; refusing video enable\n");
> -		WRITE_ONCE(dsi_bonded_cmd_failed, true);
> +		WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
>  		return;
>  	}
>  
> @@ -646,7 +650,7 @@ static int dsi_mgr_bonded_cmd_xfer(const struct mipi_dsi_msg *msg)
>  	ret = master_ret < 0 ? master_ret : slave_ret < 0 ? slave_ret : len;
>  	if (ret < 0) {
>  		/* Never reuse a packet buffer while either DMA engine is unresolved. */
> -		WRITE_ONCE(dsi_bonded_cmd_failed, true);
> +		WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
>  		dev_err(&master_dsi->pdev->dev,
>  			"bonded command DMA failed: master=%d peer=%d\n",
>  			master_ret, slave_ret);
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
