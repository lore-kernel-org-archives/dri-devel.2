Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56E2CD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7DF10E5F9;
	Mon, 25 May 2026 08:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX053d1Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jGwpaLfX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0B010E440
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:30:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P5UWtU584331
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eGql5wxVNnnYcdxmviTrasFo
 Jka9bNC8wHetOEqs+pk=; b=WX053d1YypNgIOAyPV3DSbN02IbQIuWMP0tVPYHf
 TB5g2KdsFy7r7/PPIMv3CY8dtcKEFzDvrfbhXVqkLKq0qiqjdBU3h1Oc69xSFZ8r
 /iuK/i2Z6iXNEMCKuzroJspCEchlsu0PDoS3miqNQgisfgAPVx89KtonbsPS4+CH
 7gInSjT/jj8AKtPH8lmwhqsmOpLzgMVyfCPVH5sK8svnOw/TO18lF0VkTt825fgS
 LMIVF+fJdesifTJs9pniFgfA2YXDnCCJ0saQajQG/swPh1ZV3x+JMEzSnO8oPZ1x
 YtilVN5niXsyQBOEbbJ42+kM4Us/Jf964+CuZ+LhjaHgJQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0w0uk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:30:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d1a8a6c8so19570901cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697854; x=1780302654;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eGql5wxVNnnYcdxmviTrasFoJka9bNC8wHetOEqs+pk=;
 b=jGwpaLfXNwU5quawgNg1ImTJDf3Uha5289qAM30IWjGhItlybSeAgHG4b4tRZT/fIS
 1BoPitWy49mchsR0FpgqKVEFa7cTWZPpKUOCoGLilT4eu/aqScQMHZGGv2y3RqOt3Whu
 o5FcW3N6w0My9OXKAnHPIDVzkCHcav2ddvRvKn6+oaMqdZl6i2PE7mti/SEyYZ/AlK0Y
 jYeRSfjWMSOdMCqQTRa95RoOTMb73M70KHms1SQY3etk9yLrxQZo+cbh7ScgrU+lMkbQ
 oF3PY41noMp0/gTlrFyV7IrNMOzKTMhx2cVwkgR2DuYSnNdsGxNGoWjMUqtRRdEYswFY
 rpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697854; x=1780302654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGql5wxVNnnYcdxmviTrasFoJka9bNC8wHetOEqs+pk=;
 b=j8/6nEtpvAXmT8EDdOgqVv2s5mQ4PpmmK2Dhq8/3oq+ZHHLBnHx5cOBHxiyEs+BITY
 BinE0GsiOBj9KIKkTeyFbMKObvUTWut4H8SdL5FS9zhPsvucnuievglFaupe6c5oMvJZ
 0UwsctxbkJPUfvt0eWGgoJo+NYgezpMGyrGC5CjIS0WhHpIUtk9pL/hrSiIaCuVN+Vwd
 x4afOuD/RzMAe5eVPM5Thq/J3VXzuBbFMYS9G6IzzHHWNtsYZc6/tO8v9lJr0D4RVJIU
 phZ1D3LZTg+KQ+3Ysy/K3+NEa8svH+gbUBey+aSMTaDsnVn1dpliIkqawnWq3XWnnl56
 11Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ824YYIdJE2n4sZ/LlTSaBd5naGK9t7yzrdznXpOhRYIKpiIvsoSqvuuNUvh8KToIPAKEeWtTi6bcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxXtqmuCpFhFXV4stUqCRORU1oj8HV4udotLqSqkyIVPd38PDM
 7BI+ZDtVyQshoaIiCqzViRo5rLzC5LdfscKPpTLJxfdsQrbukN99Kv7XIRDJbyG5GePzIgVK899
 a4hmuOYtogFodBPGJSaxWHTptzOubntA+FHSKIhkCd2bBv7y9OzbhnNPLOSrcBg5GriI2VcU=
X-Gm-Gg: Acq92OGkL4P9NEcBWlowNFrkBZgXyJi/YdPmdLzSmo0KlW0dtrEIosJY+Wuy8L378Sq
 jz6qghJGp29Ac+FGjs7DJ3xJlPu0NM4JGwfXnTRm1mVa2X6IaHFbk8MVvPnBzi/RIS1I2VhE7Nc
 dPDSYt/Sok4o5KmWJnZzhSgjamx0ow+Nxryt4L5f/mj2kl+GgewFP3ePYLoFVIrcgTezgs/9voF
 Vn/XPvLvTNutUtZayizOFJCvlLhOoi/Im1fw99pSONCZ7yQZ/8S4I4Wbv7z9iqb7mQkxVpwKzNe
 AYrGUQLioUQooih1t53sJg/ywVAsaQhdiqQ1h4wIZsV9lcGdZguY41XHFXaFsyW+xcI8JllF9gM
 8/VGHsjaVknG6upRKZBqiF94tiDstK87Xdgo9aZRUFUMux/duEjP3oHSDf1IHgHNZrpIxZSgxsJ
 n/8rySQkYbejqhJoJqzm5ymOwuZ5jHJsOFGpI=
X-Received: by 2002:a05:622a:8e0a:b0:50f:b978:82e9 with SMTP id
 d75a77b69052e-516d4409d8bmr166291651cf.14.1779697854290; 
 Mon, 25 May 2026 01:30:54 -0700 (PDT)
X-Received: by 2002:a05:622a:8e0a:b0:50f:b978:82e9 with SMTP id
 d75a77b69052e-516d4409d8bmr166291431cf.14.1779697853849; 
 Mon, 25 May 2026 01:30:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a4cdsm21731631fa.19.2026.05.25.01.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:30:52 -0700 (PDT)
Date: Mon, 25 May 2026 11:30:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <lvfwkplrktjldbvn3j3jqh7ds25prx723at5t5oobsvhgolngs@pme6jiac5xdg>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wCLabDhijuS9kjOoX9e0CQFCbzDhqk3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NSBTYWx0ZWRfXz50BNPD0gVGu
 IEF8raE4k/yC/gKLe6S6Bt9ZqlVRxFmdkuQX8B7AyT7xtSPe1VUtmmONTRV+rAaWjrTrJFrJuxn
 oI/Ps1lFIWqGSsn0zb7um6WhSEPzLr4razaekIOdisY6rw/CPt6tAhEXeTDDmVVS0puR2DQaySQ
 St/jRVGxvSqdcATFbHdQjJCs7HH2qYhUlsLJV6ZKpNyyzITx1u3/8SxuGxdyF7bR56MM+L/zEJi
 rFJTwxIvcE/jXYNu+EUDZueliwcYPBfVhvDviF/o3ZNqiuPjCToonvovMMk7BAULQusvUM+hTaY
 jo6c3/N3bjDGpyGpMF8KYT1zJwTQpoAt41aZIMmaCAPFSsAQS8uWjeZTb+xbOBtSnu/EOasYmBy
 E4X9PrsssND9GR2/k8TgDby6GyvSRmCZgbJAGyeZIQW2YF8k1QkWOkZcMj7+Dm3iyvNvNPVlxTx
 dC5THjP88K4xSFQZfvA==
X-Proofpoint-GUID: wCLabDhijuS9kjOoX9e0CQFCbzDhqk3d
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a1408bf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=RUoLUfHmO0A8xNlmPTIA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250085
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

On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
> 
> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> > On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> > > From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
> > > 
> > > fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> > > getting removed from the list after it is unmapped from DSP. This can
> > > create potential race conditions if any other thread removes the entry
> > > from list while unmap operation is ongoing. Remove the entry before
> > How can it remove the entry from the list?
> 
> Multiple threads sharing the same file descriptor may invoke unmap concurrently.

=> commit message

> > > @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
> > >   		return -EINVAL;
> > >   	}
> > > -	return fastrpc_req_munmap_impl(fl, buf);
> > > +	err = fastrpc_req_munmap_impl(fl, buf);
> > > +	if (err) {
> > > +		spin_lock(&fl->lock);
> > > +		list_add_tail(&buf->node, &fl->mmaps);
> > > +		spin_unlock(&fl->lock);
> > > +	}
> > Is it expected that userspace tries to unmap it again? Or why is it
> > being added to the list?
> 
> User process can call unmap and fastrpc library won't call the unmap again.

In the other email you wrote that the driver can be used by random apps.
So... what happens if userspace unmaps it again? What if the userspace
_doesn't_ unmap it (although you've just readded it back)?

> Fastrpc driver will free up this list during fastrpc user-free.

-- 
With best wishes
Dmitry
