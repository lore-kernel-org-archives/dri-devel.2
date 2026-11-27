Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hcv9gEKg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z5nHLZJb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC7F112D86;
	Fri, 27 Nov 2026 20:16:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DF8112D86
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:16:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAoJT2127653
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ogpfngdEHVCrVGXs/lkHJBfS
 JJ+R0ZTTBq7wN53YBBo=; b=hcv9gEKguNzNCT8j/mSo2BPn0A6aELN97/y3uMxf
 EERbDM8CieNBWeSmqVN3zISX4KPcPQEhzyaOLGPZA2cTywMvkWTZqhO/5dCL5aj3
 2jYJi4R21B5KbsxGHLK99exphoQr/pLYILVA4xqymhJ+R8e/BvbRZn50jGQnS9Am
 BSI//EJtC4tEKvFIbtgVDLhe7ByflCPOlLI4AZvRTQhUu/IvURR8I1pRtXwLXWDn
 cPdDheXkkwf/4mcvHhmQD7iUHCJ61yTFdVm/FhLfYK/EddY/pRAZU9VLDZ+OnQ8K
 Wt4wQNAexz0CUXlSao/92LIzE6dOnBzTG739c6BmYnMTWA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e7d0dd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:16:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eaad8219b0so2736230e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810582; x=1796415382;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ogpfngdEHVCrVGXs/lkHJBfSJJ+R0ZTTBq7wN53YBBo=;
 b=Z5nHLZJbGm/bUN5LfXDT0/8KpX99O/r/dvwerwhqWEfkifWk3KevBs9xon14ZoUDCq
 SUpBPE0a6eT6bh31x3jMyJzNgOuG6l14b7Y+2Kkt7rUl9bzj9OBlz16CEk3HPG8ebES8
 ldWbe2qUuJY0GNGXt/wY9fhx3e47sXlvfhu4gR3/V276gVNSJRwrTJZ0q8f7ORcuk7sm
 ZnzVEX633e3HHbC+3wpDlndvc5I0ugW+G0BERnxXsOMOuRk/0JwuTRtE47ii/E1upWAj
 B+mdIX3k9eeXg1gj3e7k5zVZShEgVwiC9cmY9rjacN+yMdT4zm3MO78RgxwZNbMdlMwf
 2zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810582; x=1796415382;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ogpfngdEHVCrVGXs/lkHJBfSJJ+R0ZTTBq7wN53YBBo=;
 b=ilOYRgF8ar6v++pRjTq2nR0HFqkyjSokHCgAPi1Ma3jQ8DIIHMMO1/2W/kSmpCu+nT
 nM4fm7cZjLofnIfIEJPw7jTdjQZU8TnIm3nWoxfyQ9/btOHmEK4hPufvFLPvrli1L+My
 bJ1UkdBzZzy5RGWlxi7WeV7mBFvKmBrmiubFxfsSck5zCneJs3X/XfFwnKMDjFXr6IVv
 PSRgNsw2KTQdPsxFOEzByXKZmBFbq5BdrNqFRLY4uv5eEnRFK83kTGlU4g2Q8zBqccy6
 Hzx6VOLID82AmaWh6lz2LvadoeGXuNnNk/voUkyPv7kMgjTsp4BikdhRtW41bwvfMGlL
 synw==
X-Forwarded-Encrypted: i=1;
 AL+hErExjoumxa9+L521ACw2WBDHubPqB0LBUR0cC6Vhl0jZvuT/yoZNDybKByjLUtREzfR8KW/c9sIYezU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8a4wy+Ya75LiHR3WjAf6jlB0TZR11nk0umpNRLH9uM6/GVW0mV
 nA+wxwQgRT3gk7GnLIFXgFR89qMFMG+9fVnpEz54LBwQ8vYAYgEm5tYoIUPb2poIeIE0kdcE1XF
 bVp2SzkE9sucCRB2o8+AdHn7XD8Ixc3QJ51DA0LdxeBpNurLcn1oZiZOqI5mjYoglyaLSPJg=
X-Gm-Gg: AZFdTZe4S/lz11+IcaMM8Dn5HCOiV1jjp2psU3cYxUlUUtAG8krIt4Oxkw7QTy4kfUz
 9fN06EW72zEad2EF/aSM/GM1czpSpWrGWlhehRp/l+DxizDlGR+LCK7JZ5fFxllwUivb3vPqMcU
 pR4E5vwjpjyIwpgz8c1OLT0ApdFALajV6rukTYFndtCjWT4rz4ZK+qvvpJ7rol2ypjt4U3vAigu
 zTtei/NZkMwkaEkd4gw7qdOS3fQJEAPyhahSAdZguvnbboiXXFqKvUIQXxcuPZm8GFHfgNhFO99
 qpeF/+qPQrLvvVjF5N66s4TrwRDUOAdXK4JjdHO48HNUVOwKLk7wjD96r7K10OPvV9/WIwOHYuM
 AkvJYP7AybA579Uo48tt1AMkuN2IkgTfnj1J/AwGJ1iEU2Pp8vyfveoDaUVXAtlPz+zedliFBZH
 wNEilexkrkP1/l9Ya5I5vAC/zCwJxdRE+AxziWThkyog9dJ8V2dpsghb7WAz0x9g==
X-Received: by 2002:a05:6122:1784:b0:5ea:b294:f0ab with SMTP id
 71dfb90a1353d-5ee8adf34f8mr15650766e0c.2.1795810574211; 
 Fri, 27 Nov 2026 12:16:14 -0800 (PST)
X-Received: by 2002:a05:6122:1784:b0:5ea:b294:f0ab with SMTP id
 71dfb90a1353d-5ee8adf34f8mr15650058e0c.2.1795810571119; 
 Fri, 27 Nov 2026 12:16:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd043387sm6206566e87.49.2026.11.27.12.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:16:09 -0800 (PST)
Date: Fri, 27 Nov 2026 22:16:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Zhendong Liu <yzddmr6@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miaoqian Lin <linmq006@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dsi: Fix double put of the PHY device on
 probe deferral
Message-ID: <fetperibduweqak5gdpdahzqb74zs5f4e64l2qc5h5cwolqjkf@4mteepcow6g3>
References: <20261127-upstream2-msm-dsi-phy-ref-v2-1-be82aab71166@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-upstream2-msm-dsi-phy-ref-v2-1-be82aab71166@gmail.com>
X-Proofpoint-GUID: ap25QVdQNzJKrPwyKSzeDV_a_cjSZ-aq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX62Oev3kYPVzT
 uFUI1ky1/6B56ERFYDl4YMldWhbOlKe753wnDeQ7G/XEPVXG44YsWHjMDVg+DkBJ0hD0L71w/UN
 6/SmSyxrb4HjzEvVzxLfPo05noUBasjHJSH6fgn3MOvLqVfjjXLMrtCtnghXWcaisxT7axE/dHs
 SimUnI1kIRqVI32JTxSHKZr4erm/XkVY/Rn7nNpoBwHI8qt6ZTa9AQruE0oCGfM6WuSsE9q6mc0
 eCkzZ7fsbK5/Ot1DtvUKDi5qUIHCZDur3MFlAyfG9C1N2GHokbfMrh+3iyP8BaHopmIapm6XhfG
 0S5Uj6BpYhIT/Ltri0CWpCuuksAuWN4XW9QHRo0flFeAQcYLjMlZgIZS+njB+dk8LE2YZjujxU4
 lM8BkjKRAwsEnPO5nWricD5Ip7MOsm/IvOZY5vvJTI/5c4cijxekaAqkMkDKc8qNL3Bgz+O2ESy
 dW/INHC4tgtm1HXW6qw==
X-Proofpoint-ORIG-GUID: ap25QVdQNzJKrPwyKSzeDV_a_cjSZ-aq
X-Authority-Analysis: v=2.4 cv=cJh1IVeN c=1 sm=1 tr=0 ts=6b09e517 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oPjNpEVOrg6OkQjzHwMA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX7jI5JfbAhLmM
 +wOfkL8/QmWAmEx47ZVzT+FtSM4xRYiRiZJpWHULz0gsvd44yiQvf1acdI0sKKeDfuytSbBEap/
 ikMma09xIoF85tC9dvmoI74q58E1foo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 11:24:37PM +0800, Zhendong Liu wrote:
> Since commit 6977cc89c875 ("drm/msm/dsi: Fix some reference counted
> resource leaks"), dsi_get_phy() stores the PHY device it looked up in
> msm_dsi->phy_dev before it checks whether the PHY driver has bound, and
> dsi_destroy() drops that reference. dsi_init() calls dsi_destroy() when
> dsi_get_phy() fails.
> 
> Commit c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in
> dsi_get_phy") then added a put_device() for the case where the PHY
> device exists but has no driver data yet. In that case the reference is
> now dropped twice, once in dsi_get_phy() and again in dsi_destroy(), so
> each probe deferral for this reason takes one reference too many from
> the PHY platform device. Enough deferrals underflow its refcount and
> free it while it is still registered.
> 
> fw_devlink normally keeps the DSI host from probing before its PHY has
> bound. The path is reached with fw_devlink=permissive or off, and after
> the deferred probe timeout when no driver matches the PHY device, as
> the device link is relaxed then and every probe retry of the DSI host
> drops another reference.
> 
> Drop the put_device() and leave the reference to dsi_destroy(). This
> effectively reverts that commit and brings back the single check that
> it split in two.
> 
> The double put was found with the help of an AI coding assistant during
> a review of the driver.
> 
> Fixes: c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in dsi_get_phy")
> Signed-off-by: Zhendong Liu <yzddmr6@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
