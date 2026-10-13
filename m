Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5588CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFC810E7B6;
	Tue, 13 Oct 2026 12:25:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E3310E7B6
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8OD5t3054788
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SIcDQaXu/994wf1s6RnqNPUd
 3EMpsW+IvnRQHDqw2Qs=; b=HMAnlZC0KAo+kR1qsnV8zVEZJBFpnpzfHH6I7zey
 UJ6iu+ZZnVvxfLZovIvmbO0gEeBgsiIzIaVph/NqgHqdzMEmW9DuVCvS7dfLK4k4
 LXfBh60NmRJPeXNp/Z6gETmpgub+Orzd4+wMZrp5ZNJZ1p1HDmJ6COxUMtkrkSel
 0rgM9T0lSBB7hpjQKycUmxHAsinCboDuxCfX4vHp4riXMr1NZziwbsnZGisXSDV5
 VSQTKZaSV/tAJ52U6h0nnxdJWbUnHAl9caIumfS87v+YD83mKt27BWPITgXtuft0
 09tS+RMOwByXcvEXTE9GLTesWoSIYQLRkgWlSk6hnGUwsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aev8uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dd3c3badbso651168885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791894310; x=1792499110;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SIcDQaXu/994wf1s6RnqNPUd3EMpsW+IvnRQHDqw2Qs=;
 b=IfVGUcaYySQ7QERnlsXOwCW68mmynQMuvOJ1SsPiAehTh5ef9WcFYr4JprsftpmT57
 vmjHQ9gNAONLaBm5nGXJMqML5W5pz/yk9lA+l3GeZXWCmDygot4vgqLKh/J/QajvvifM
 xy/T8ktFJXaGCI2+dcsgMJWMmuW8j1weZm3yf0YnNdxVmtN76Y3XeBqr61h3Xs2bcP5x
 jg48hG/6Zk5ZKREVquxSkDOMcIH1zLPhPtNrLXPdyXYzAfdGnNExObPt4XKi/ZdunN/D
 cpzQND6VbqCAG204vomaL+nnNyIPeNp+LW2geysCKIyhjHoMIaqmSwYdYZp2WfLuWRVR
 pd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791894310; x=1792499110;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIcDQaXu/994wf1s6RnqNPUd3EMpsW+IvnRQHDqw2Qs=;
 b=G0zxDyNPZPLHXhR7vbs4Zhhdqv9DamYHT+70V0UIYTaE1OlIrIGhOh6HYzhdyHsFxd
 06bvttudnmCQiFe1NurUoq8ggSDtUcP2LRv4bKK0ZZQdr6Y2RODkaHUya8wpCO4o+FeP
 s7kcaWF09M9SjsBnvHfV8aj20+w6/Nm6b6sbAhLDzqFdfBS1IVKCtsMz8uPRkkbmaycP
 SMJUYmrtC5PQ/51DruKQ0em6YTvMWB4Lr3T5eH4yBMhJtM3OCN3YKLYlZwruNie4O10C
 h/UcPOavvxXve7lYO23BpnudNDHB37nlBJ8XA3VFiqXhCGrDej+/xJaru32N2VnhlhUy
 SMHw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYUnC3+Z4xYSDiWeZvayqZlmxEDSsrBH5OJhM98ObKZcdWgWMY+VLgy2XYVb0MQmELPv5i/OihkmY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJ3YE1gzKkBJmdXVo7D24ZfXswSz4xjT5eaC3ihMnz+Vn+4eLW
 WPbCvk0y2017D9wpk6KieVY5lhAPHnYGPDZEwZ6GjXlGAUh3lkSpEiad9xFHVLCbO6cdMW/qOQh
 diUplZUpvG2GhoSDsE510lTlE+Vwj+6urISkd9sqxmkT80l9ukDYz1lpvAIMM7p5YbcK7cTk=
X-Gm-Gg: AYBFou1oPpt5hibwDLHedK9d2UM7kUfaPbrLZ2hzp7+kBmBjNr61YTPZx9EH24ehm7+
 kmQhKsxQeNVCx8r4+Xr3L3R4LOrfS2Zk2qCcb7/EUSfovCNJpMCPhzuRv3DrspyGqqs1XjaBG3B
 fvLswDCceeHkMcKYvk+q3MNn8uP5hMg0oMtTqcMPV3TETUasj7QN/G1EkE36qwKlwrGzSvLk6tg
 a+CC8GAtJ16z/ePNIVcOKGcya9CZ5Z1UoOQhNFrEBKPavrPvrso77ofGc/kuqL6fU0XWMUKDvmC
 LQYm9Z/wMK0N7EJa659IVCIfGeDA8Qg95PWDQx21ICOp9rpeTnnDIMIf9S5R6VWmd+sKyiLWKjo
 gDVwtr8d09JpKerhpHz6AnW0TDK45K1ozfMasw04yNttcVifyb6KetC3RkEmcvfNDtekLzwH0hb
 t9pQ8sd5uDbxQT
X-Received: by 2002:a05:620a:800f:b0:93e:c12c:9b70 with SMTP id
 af79cd13be357-93ec12c9f31mr1932231185a.75.1791894310121; 
 Tue, 13 Oct 2026 05:25:10 -0700 (PDT)
X-Received: by 2002:a05:620a:800f:b0:93e:c12c:9b70 with SMTP id
 af79cd13be357-93ec12c9f31mr1932223885a.75.1791894309475; 
 Tue, 13 Oct 2026 05:25:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3c9c17dsm35386631fa.13.2026.10.13.05.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:25:08 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:25:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/panel: stop mentioning deprecated
 devm_drm_of_get_bridge() in docs
Message-ID: <abqpm452aay32w3kpxp3wct747vi5shxged4mgf5o4u4fmzbfe@5gy7uwpxcap7>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
 <20261012-drm-bridge-every-panel-cleanups-v1-2-0fd272f486b6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-2-0fd272f486b6@bootlin.com>
X-Proofpoint-GUID: kuDXjO_Xx6y5BYZHWq9am7glQGGarHFg
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace2326 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=5gYlZd5X36b-6VqQ97oA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX3a3ZBkTXW0A4
 vb2+WqHNyHh5cTfr6W80dBSt/OhiSMAaw5KJzLrva54v2C3+4rNBp5ZjXlck7uY6SfG+nyeuFNG
 F//jKBk0Sf1Sfw4xCuTV0mJP36+T3LM=
X-Proofpoint-ORIG-GUID: kuDXjO_Xx6y5BYZHWq9am7glQGGarHFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX9umQLJURMgOQ
 MXXg8Mti5FMspqNQNfs1orLkU5IHKidpY9tFiG3YC2yLwT8vTHrvKfef/cMv4QyUyHFdxjFcepj
 /wsrZlswl0fPMefs2OjMAlRMODKyl/it6Au7KcWJVru/mOCCducgfNEAE+JiDJ64b8X67lzvUXQ
 dN+JeioR/uQX9Jf48JXjftoKFSAZgFpuXof3k1b+YCp4slFXYYqCdHwGmwIPrRaYLu6eSzGXKRk
 HMObK6HNr12+1ZsXUiJ7E3428OGkVS5dqd0FvmGqB66shg3hM7PWR92uSvWuuLdOvasTzm7eLfj
 YNlftEJLnwBlfZ5ZA+pSWwdhiG45VZ+6NL+wN8DfkIsC3zvvwe7VXtwEVnaR9nhttbpVJH2hHXW
 Q1LDUjgX/iErU07XtOeWmPwdxOjgKlik0xjFkksriMtCAduUo3k3/6nxyhR1AEKKZb7rEL6gREg
 Skbrc7dpt+GNGJmwq1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130049
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

On Mon, Oct 12, 2026 at 04:29:52PM +0200, Luca Ceresoli wrote:
> The kernel-doc for drm_of_find_panel_or_bridge() still mentions
> devm_drm_of_get_bridge() which is deprecated. Update to mention the
> currently recommended API.
> 
> Link: https://lore.kernel.org/all/c1b065c8bd926708500b7c42864279e055ed95d0.camel@iscas.ac.cn/
> Suggested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_panel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
