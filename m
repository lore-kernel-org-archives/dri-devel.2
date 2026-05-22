Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8A6CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 20:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5AF10F6E8;
	Fri, 22 May 2026 20:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbgztTsE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijLzRe75";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4BA10F6E8
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 20:09:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHF2ES1800764
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 20:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=; b=EbgztTsE1C9CerSE
 ANTpW3uvn5Il5z/EcdPUowP+j1DovIhpYLkshTBQcFSp04zrMrdGzt9VrEDdhC4u
 /OS8jPtLzIIC64gNN8r1/jWRO1QKY7ePcVrH1lXNsJdefWwgMAsp1OkdSnzgxz2A
 RmeUVsDokIDB0hnA0AhEfhHrMWZiz+A/5xNfbXHXQ2JjFfmAuTexFDG4uSh9GBE4
 Uj7Hhq2m1Z1Dkp6h7E7qH5ORpxVxb0PHRo1f9A+gQd3r8tvMFo7+/vT88LSzxMd0
 CYtP3evhGCD5OxWn9UeuQY1sqK6HwmFMAEMNY2/FH5RrzV0e0fIlG8WG6aFtaO5Z
 vTsYIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g276u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 20:09:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-910304978f3so1550879385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779480560; cv=none;
 d=google.com; s=arc-20240605;
 b=WroFXXKCb9DkI2jdhNv97vqGArBdB4Ko5d9sTbjBAtgW2mminaH32pGU3p+ok6Hdvy
 3qgYRLkXmXO/Tfw0hv6g+ClSJPmU25opORe4DVR+JoM+dXBP6BKGil3CM921SnlglJ6V
 5vjwXMv1eduxTQJqjzpTXSErDJmr1uj6E6FnY+y67lwDUsYenZkQi5yWNq3AAiNr1Fet
 yy7SzrcMS1A7pP14z9UPc0V62TCEbI0ygILGdT2rAGCnbYFhcmwlsyEY9ogc99zw5n0m
 cx0FUhp7iSNVAD/3Qi34T/DiSIk9lILimvLH+BI41isXjZWjntwhgZYeT72dpGyaspdk
 kh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
 fh=NvCF9+/snIjQOrmZ83TfyqOQhTrT3NdjrGuPz/NzXSU=;
 b=e+T1zw0GZpEdVVd6Cmx3Zic+m8JBelda2LKKjcj6qcN4kh4tabU7XwNe3pB3oWcbvw
 AUQv79HTwDDpE7QplafKCGsUrmZw+YN4IH0aq6cYyPY6Zs/b2VLDulVZdaf37d7FfQJl
 nooo3/VJKBgR8n43f02HsKU/Py93KZ7WNsTNuVeGN6BHc6gKfy0EEcGhyg/l0Fk+EMaa
 ZZPessVyYMmPU7ArrYr2rSXEFovIsDLEtID4MSJbrH8y4uwFIH/0pe8+fJAvLHrQRfb2
 H6JB8ACYB2+xDInoc/Eo7JPdkjC6jDTnj3I+c9yol1LVAVUKLDU5/BtW+9SfS2K25YII
 dyfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779480560; x=1780085360;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
 b=ijLzRe75xVJXGCGxEsJhxwEKs6B51d4tsmBVur5F+ZWIp+GhByXAdgfOE9CJTnykbv
 M0jcVI1wg3Bq0tJTdfoHtWOJUP36xKgKa2pz1t+isnoSs5o+LNoTrXMbWHawIIbCUszR
 JL7wPEaxS2g3V0ADslG5iWahH4NTs36z8bVu0JqXb6ZxqveLLI62M+L+MbKunjxV6lu7
 mr6Pl3mYatcf7pKx7y0OC75o3NbRFhM8NNQKWQkKQjjs5ZJMdFcsW3tJ6VvVFVUL+KDg
 omaPiOe68EvzUAlGVGAGWyEcr7/RczwNxsieUpBVm2PfUyghvqOYPoVvAaL74igQ/Nsy
 GNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779480560; x=1780085360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4mgJ5edVM+mqGwYghHMz4APWCN08GCaqEMyrnNrUOWY=;
 b=oG076bcp3EfMQ3khSmPQMf1L1ud7Ycxb9fKm4hB/VM/0ZaSTOy0k+WXSKj6a2Lqy7T
 52TQsmLKYZSb+EiOVFZkSNc7P7wzFAwXPwODGP2EHqNc8pgOlQjLhTpvlIQt+vnn5sYl
 mtPgWWr4kHp1SwcBOduy/WxaakXkZ9I/4bxmrjQNVs2Ji0o0SxYc0CSwgBb4XnwNIREl
 lSNoXe1K93mD5Pho9+A0fi1QYPLQ189c/MUrsU9RU3fFxRhGATdxsGBlHB6GORtYVhy1
 Aa5tuVepdmdMZ9Sk/61GZfqjPLD2tqDczUp/cmv4efiG194Aez6I8ag+DVNnDawzoq7E
 ToTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yphgSR6rMcZbjb8geJ+qubg9I3ZBvXpGJh8zmHceZ8Rg1qAdYFyP0prkxNabqqR9AX82RL9bRvWc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFCzdQsNNNjlpwdF2e8L24HXD/s1+pxvGHHwkQiLd+w35I2eDe
 Gs6kK103VfS5lOHFJ6iU+UIiafxDnnV9g94DEKCyN9FNxYnxohs4ix0j8FsyrdIpj+3qWR4cF37
 ZznhyJmmz37+XwpANsSXuA2Cz5EpJAvs50NrbWvMf6CAHZGcBQtQhv/U6Q+9uKyNvGs5hYbtbRI
 9EEaQp6iyoFMsu+hOTwbL/hNdAmW9WGNuvl3H1HaJP0VxAIw==
X-Gm-Gg: Acq92OG/0h+Oj6kmfJr2RBj4Nl2a3q711sEtt+n9eXMY2dZUr2I/v7QY+lGSeArG5JY
 heUlt5lkSacJpbK8UUT7msZgVf9UXrHcVPrKrsZ/l08YejGbj1iTrA6OxdDSsVpHlHV85ZpUtFI
 FFTe+HULFtHxvL9Z4K1BV7KqKLy/Dt7D8s8Hrjo3Db9DIgyNOoHv9zR5OQXKHmzPpwlqZ1TUy4F
 8+ghRD/wSCi46QAtZNhP7z+brSPxX/hMp/gbxr2JXbj4v9er6fDdCo8oKMiPjtgAP71
X-Received: by 2002:a05:620a:28c7:b0:8cd:aa61:ad8f with SMTP id
 af79cd13be357-914b50cab94mr617028685a.14.1779480560185; 
 Fri, 22 May 2026 13:09:20 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:8cd:aa61:ad8f with SMTP id
 af79cd13be357-914b50cab94mr617022585a.14.1779480559708; Fri, 22 May 2026
 13:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
 <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 22 May 2026 22:09:08 +0200
X-Gm-Features: AVHnY4J-9F8AAJuD_tJW6-iaDPIYDcwXI9s5goDnYZwmGPWaSdjsV19cBJfwNa0
Message-ID: <CAFEp6-1sdQn11NKom6cfwtJvZX-CnPRpJeVzQ+99Sb4A4L-qaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
 quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: k4Qjikq3uTtp9kOgQIZiB4OhWv4otY3j
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a10b7f1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=omgbQWz8Cy1bZfrwG_oA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: k4Qjikq3uTtp9kOgQIZiB4OhWv4otY3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfX2zTZu7gKs6h/
 NOmnZxpnYOgfjF9DlV/+Hygl9bKMAxjhht/HHNIK1qGnAzyWpYzC58R5WGaJnKfpinbFVzkSizv
 lTvGlaextsaT2FoKhf2X3iPgYkntHDaOx8/b/ZLX13bH09jopNecSnepx1cCGaglrJo3yUWkeqT
 6IYfq8rI9KvNi+tQON3n/bEm2UCof8NdgI1LzthsU0y9uh5AjKN4Yg+kvJtTVi/J7JenK+lxAeV
 zPiI2n/BlKvDuz2Q1tPRe74h+qPhr9DkSsZvAq3Y31+IEjoxmKpWcaMoTJ80AZ5Fblt6nv2mdYo
 cunyTAtHl3mUZuEt8MCwI4VgrqyBfWfxVjDAYQ5aiPpR+1g/VNGaiuHE8A4GKyaZVyESsmxHNQC
 Mz8n5QhdoRNr6J/KDvGSt/kQ2bk+k2u+W9S05W5ghfo8NC8gYiF7GCjMSW5GMnt3K6xVewkcZeS
 eU4zndsIE5HC4k7BZ0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
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

Hi Krishna,

On Fri, May 22, 2026 at 12:01=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> The mhi_net driver does not coordinate with runtime PM, which allows the
> underlying MHI controller to be runtime-suspended while transmit, receive=
,
> or RX buffer refill operations are in progress. This can lead to stalled
> transfers or failed queueing once runtime PM is enabled in the MHI core.
>
> Add runtime PM reference counting to the mhi_net data path to keep the
> controller active for the duration of TX, RX, and buffer management
> operations. Enable runtime PM during probe and take/release references
> explicitly around these critical paths.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8..5d7f9ccdb17b 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -9,6 +9,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/skbuff.h>
>  #include <linux/u64_stats_sync.h>
>
> @@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, =
struct net_device *ndev)
>         struct mhi_device *mdev =3D mhi_netdev->mdev;
>         int err;
>
> +       err =3D pm_runtime_get(&mdev->dev);
> +       if (err < 0 && err !=3D -EINPROGRESS) {
> +               dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
> +               pm_runtime_put_noidle(&mdev->dev);
> +               goto exit_drop;
> +       }
> +

I am wondering what the value is in pushing this PM responsibility to
each individual MHI client driver and requiring every MHI operation to
be bracketed with runtime PM handling.

What does the client driver know here that the MHI core itself cannot
handle centrally? It feels like ensuring the controller is
runtime-active during transfer could be handled generically in the
framework instead of duplicating the same logic in every client.

>         err =3D mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT=
);
>         if (unlikely(err)) {
>                 net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
>                                     ndev->name, err);
>                 dev_kfree_skb_any(skb);
> +               pm_runtime_put(&mdev->dev);
>                 goto exit_drop;
>         }
>
> @@ -251,6 +260,7 @@ static void mhi_net_ul_callback(struct mhi_device *mh=
i_dev,
>                 /* MHI layer stopping/resetting the UL channel */
>                 if (mhi_res->transaction_status =3D=3D -ENOTCONN) {
>                         u64_stats_update_end(&mhi_netdev->stats.tx_syncp)=
;
> +                       pm_runtime_put(&mdev->dev);
>                         return;
>                 }
>
> @@ -261,6 +271,7 @@ static void mhi_net_ul_callback(struct mhi_device *mh=
i_dev,
>         }
>         u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>
> +       pm_runtime_put(&mdev->dev);
>         if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_=
DEVICE))
>                 netif_wake_queue(ndev);
>  }
> @@ -277,6 +288,12 @@ static void mhi_net_rx_refill_work(struct work_struc=
t *work)
>
>         size =3D mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu)=
;
>
> +       err =3D pm_runtime_resume_and_get(&mdev->dev);
> +       if (err) {
> +               dev_err(&mdev->dev, "pm_runtime_resume_and_get failed %d\=
n", err);
> +               return;
> +       }
> +
>         while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>                 skb =3D netdev_alloc_skb(ndev, size);
>                 if (unlikely(!skb))
> @@ -296,6 +313,7 @@ static void mhi_net_rx_refill_work(struct work_struct=
 *work)
>                 cond_resched();
>         }
>
> +       pm_runtime_put(&mdev->dev);
>         /* If we're still starved of rx buffers, reschedule later */
>         if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) =3D=3D mhi_net=
dev->rx_queue_sz)
>                 schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
> @@ -362,20 +380,41 @@ static int mhi_net_probe(struct mhi_device *mhi_dev=
,
>
>         SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>
> +       pm_runtime_no_callbacks(&mhi_dev->dev);
> +       err =3D devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
> +       if (err)
> +               return err;
> +
> +       err =3D pm_runtime_resume_and_get(&mhi_dev->dev);
> +       if (err) {
> +               dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed =
%d\n", err);
> +               return err;
> +       }
> +
>         err =3D mhi_net_newlink(mhi_dev, ndev);
>         if (err) {
>                 free_netdev(ndev);
> +               pm_runtime_put(&mhi_dev->dev);
>                 return err;
>         }
>
> +       pm_runtime_put(&mhi_dev->dev);
>         return 0;
>  }
>
>  static void mhi_net_remove(struct mhi_device *mhi_dev)
>  {
>         struct mhi_net_dev *mhi_netdev =3D dev_get_drvdata(&mhi_dev->dev)=
;
> +       int err;
> +
> +       err =3D pm_runtime_resume_and_get(&mhi_dev->dev);
> +       if (err)
> +               dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed =
%d\n", err);
>
>         mhi_net_dellink(mhi_dev, mhi_netdev->ndev);
> +
> +       if (!err)
> +               pm_runtime_put(&mhi_dev->dev);
>  }
>
>  static const struct mhi_device_info mhi_hwip0 =3D {
>
> --
> 2.34.1
>
