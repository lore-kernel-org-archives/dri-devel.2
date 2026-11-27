Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F574606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3FX8NKb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E4KP2qYb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DC9112D63;
	Fri, 27 Nov 2026 19:58:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C06410E62D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:58:33 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBFuD3753119
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+XTNWIgi9ID8EoeN/DwyL/tK
 Je5joumzVvmrChys3j4=; b=g3FX8NKb7bzFF9rqGgqaeJGhFiOFZPYid3kFU+dw
 H4wUAAiqNfq2dOJU4uEG35zZVPR/mjCoWWOLltGW8MYRPw1ewdCbr+fW0r+ktYT9
 R7bGvYPtkknaZ+X3X4TUds3mvDYcrh+BtQVvOYed45LCnUHK9GIcPR7EXthKW+pO
 uxc2GME/0mZ/7Fdh6tiD1/BJ0lmxSspyf0B6m4UzCz+SyiF4OO8teYoQcaGzcMMp
 F37MTtK/umQfmwA1mP7CWtb52gXC2rLRLIjk+gdBCN60h9/32UPAhICCW9zqN07F
 pAgk3wOA983UtygjFUiDJHDfKpwkHPWgbmjlz65gKdE2uw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74ghaqcu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:58:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-949b0d3232fso1145824285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795809512; x=1796414312;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+XTNWIgi9ID8EoeN/DwyL/tKJe5joumzVvmrChys3j4=;
 b=E4KP2qYbS8WGNTAw/5nvel1oDizIbYYIF4yVYVD8raVCVJbjqBH0+69Jeh0j25bdsx
 bCGvKgBrLUTLuJKjkdQ7DXA8n36aAbvfP+w64999hfyawitY8zhwlvOeBlOB2JR51CFr
 Ny37wxvp8UpvWcqS+mKNQvireSSq/lIY1hwiecA6YvhBGhrCFJCAETudBKaKntZ9K6VV
 F0rhwYOeDTeeQwKwpECLipOdyOSAl+y5cpdBwy/RPiiEq734OvDHtKE4HapNeRodmmeN
 xb7DqOzFMAm0qgtJy6rAgWAv6WNEfcFLkOw1/RwOQOG9xBJ/kU6QEk73X3ttlNlBddE5
 BROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809512; x=1796414312;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+XTNWIgi9ID8EoeN/DwyL/tKJe5joumzVvmrChys3j4=;
 b=qMwkZgs+CSUBBjiJqT129bxnkz8Nb6VporVgOJYF2WJG/RvCX56i0UXxwBrv3MwjZv
 grY08WVDZjbDQ9JUZbG/tk+Fnta6tJRAQ24IM4RThJgue8jr4FgfaRmTTuseDjHPrZum
 u/8ZaMtmq3pkP6+l9rD2kOKYsaEbmWPwOuc9WAjTA6RY013XiDy010eaM0NjnMkko29Y
 Mf06do0RZFGyGW2dPzMYEv3hxHulFFq9dOt7wkPoHypJjlOyvT6Zm4IbXljzFQ7buDMy
 gGup+MCiotXk/XLDISzYUSaUBC44B7+8lqD3MQK47TMBLtJ1QfxQXlqUHJVrbxuet4OV
 pmJg==
X-Forwarded-Encrypted: i=1;
 AL+hErEdAbuiQrLz9TrVXoaJYo4c7NYs90iVBes66eGr7cQNMhvtv0+Z/EmfUOXcruQiLQFS0Gdsg8hxZB8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1xuS4hY4taTyYiJubvtmuGcpeqnzw56PVys5XWIdh7LjYcDJx
 YBc4ARvn5an1+Sf+XWiN0zAlCT8gsO1X1QpUGBhp0pEmV3lysN9IhWk5B5RzFWVaSZk9+ZnUpH8
 MuaX7H1o0Z7tiupe5hru6YfQvYRqKOiF8BVPyuKCvUu7zNB2dXL5evxauKBmwx67ikcUbyHo=
X-Gm-Gg: AZFdTZf9924rTfoC2spWnqCrmT8buhWVbX+cpzjVCCD5fO3c1rdPXpEUAwG21CWxn/Y
 p9j68JQmo1naGDMTh3x/m99wzGfNjhUJiBBYdokveaDCWKAmA1wKzJEKr9ih0cRG6iKXyCsYArm
 AQJmXSuRSJAmle9mbZ3KDy4B99KLE8PZu2AiTn2/jFe+Hw9ujPZNctC3AB5as+t3irJZJTu4su/
 eVwrXIBQJo/dSIuvF6/3GDP7jXp8hLDki5gbbpAdeO6EcR0gQrfnQFxA7SDrokoVp124Pm71fs3
 fOyglfBUd84eTcgevqyND1/HOOHWW3m+lG6x8xEjzvAVnAUerWJYfa7UfnzbqUDy64L5gqPRCwn
 8KBY02cdFvyfkkE6keUhSC5x+8bHRe1jQjf1T7R1D0xcu0CgEuJGqYfo3ipoQlcDzBhd9YuepAT
 Xg+hK20dcd5fbfiLqsHyPFOmYNYxtj4jMyL4dRiqqljp/dcnzQJ/KiyXv1oHm9/A==
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id
 af79cd13be357-949bab2f113mr4792663685a.46.1795809511893; 
 Fri, 27 Nov 2026 11:58:31 -0800 (PST)
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id
 af79cd13be357-949bab2f113mr4792660685a.46.1795809511466; 
 Fri, 27 Nov 2026 11:58:31 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm6192040e87.53.2026.11.27.11.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:58:30 -0800 (PST)
Date: Fri, 27 Nov 2026 21:58:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: clear the DMA buffer pointer after freeing it
Message-ID: <o7iv6phsonvuruw7oufoj3d3glo6hpknpuwedue77wnprum2gz@ws2ux4bckblw>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
 <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
 <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OSBTYWx0ZWRfX1YNmikFW7RSe
 09oqimamww08bMKiKsENP9HImsa52y5msBLrxeMsIPKVZGY9hxBFGoM5JEL26BAJHVOYiEDjUeR
 IJsZu90BoqGw70j/lq8F27MNqTkMCfE=
X-Proofpoint-GUID: wxrIZUdtZsDhzKspo4rRA1bQtV_wZZe7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OSBTYWx0ZWRfXxPAWkD74clGj
 6Vge/UoyuCizgjUZM9kRPnj7Lyhe/c0G5tOPA4KbL8sfeT9Y0f/pHkkyMD2bzmPsVBKBrADryr5
 Mm+pXSjfNokLzWzTJMDl2cRurpt3IkN0mkXnLqV7sQ9EuR//h+sA3uaOefLlzFELdGxEfje1xM6
 zkPrrVQjdFAaghzteOqad4uz1a/NdYfE099CKGiATFLTftNUsUTL/IwWKhp7er2nb/168iMAOmj
 cXwBz+cQrUTW2PBc45VnhpT3JwY/vfpg4peBbZGo43apCh1GXEl9sG5h28WHnZnsyodbWuGUveh
 dK7e2YcdS+qzHSK30DoLjzCvdXI6CcpBPjoeFuD26u1zY2fq3VZPwgmoaIyqv07T7dwVeoEp7Vp
 Y1o7rSvfdqGfF/BuQb6cGrqZbTlAIlzupapbk4mq/e3kr5l05zdt8EzgkIrwoKLgHvefmXYzEof
 QvpRqULa3Pkz/sqJMOw==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09e0e8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=JwJ85b4fAAAA:8 a=EUspDBNiAAAA:8 a=hKRTAnW6OJ533CQEYPgA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-ORIG-GUID: wxrIZUdtZsDhzKspo4rRA1bQtV_wZZe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270079
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

On Fri, Nov 13, 2026 at 03:08:02PM +0000, Michael McAllister wrote:
> The DSI host survives component unbind. On DSI v2, freeing the command
> buffer leaves tx_buf pointing at freed memory. If a later bind fails
> before allocating a new buffer, another unbind can free it again.
> 
> Clear tx_buf after freeing it, as we already do for tx_gem_obj.
> 
> Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/bug/linux-6f5085d3-ef49-482c-86e4-a2438bc1b91f
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
