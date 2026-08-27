Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D262C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2A610E42A;
	Thu, 27 Aug 2026 21:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QMHmgUgW";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180FB10E42A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfDLL9VWYZJTzwckM97ASWmtBK2ugv+bEQjtD6arEt1VBKWt96Tq35+ErLGe8e527f4U68esa5F7GxKsuficOKhzIkExJu3xosATjE4WjnD9WE/lEbWvwRJXYFG7psH96+jr/FTFMkV8ydiG/vBkLcH2/f7WCLzbCgWFAA55RfEiK1JcSVPTg1iVtJFLyd+1CoFYNB0VI+1dZENuaNrnxbnG9hHNChh8Qh4hqhtTLeP+pAxwPpq5QxKc1CpxtpLXJ9aqB1ZO0Ab69KexkEu7jyNejjetvK4tY1t9LCTt2Y8R8FMDl49BdiNAVQkykGxmxmiSczacYzqEZr8akesACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag2S3IRmX07wKyNA7DVP6aXLF08idJ8Y/GwFQuwqrC4=;
 b=MgDfM5pASs+/Fi9pyq7KNJfyoCxA4AAytePbceBezqI93kqO+6ZZJ2e5irTOV9eqzZx7giNghRKzqxfvqP3HtQZ0hQkSbqLmEFN5KfWtZ5PGRp5158kNPc1S/+EIk39i9wd2w6srhge1CikWzCJ1/zpK3wufMigscvWtR//26kBwYBas0HZFi2Jz3ItkxcFtwhwR3SH11XIspyJQsD4DJxXKQwMXtrlx27oy2TMu1Ow0OAYTSMDFGVjlvnliAnOBMzB3oc7fYkXg1GHzkhgyV1/M/CZrkq+pciAjPc4jRx757n7H/vcJowa6TWfTFdYA7yo6K2R2oi6xWC4hCshFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2S3IRmX07wKyNA7DVP6aXLF08idJ8Y/GwFQuwqrC4=;
 b=QMHmgUgW5xlMUtUBQQeqi+EBtqeTWWdtYe+PoDOzaw0epQsewq4vmmVwRqMW7XzNELMrnUtfO1E1Z9mADOvM6WbfWn5Oh1XP6FL9VZ/ZpmUX8EHJ9+sVGqu4D6stufAeDvwqMh0AXgyIJ9rNEdnT7HHCv/gWBya6ysJwd0w2znamcdHGXli9pwG6TFgBGIcqitEJ1RhNx6w2jX9DMdOLQ2cu1XGVqhmuBqp3VmmrhWQluNmSYmEVQsvpu4lkPknoSHPy8KrM3Eg4HO4lXITLDSAZ4dLYuUBs+32OViqINDf4jZ/X4OAqKtbkRLdRAHbzUM9zKvL9RkYm/yAM2HzerA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB398878.eurprd04.prod.outlook.com (2603:10a6:800:35f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 21:17:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 21:17:05 +0000
Date: Thu, 27 Aug 2026 17:16:58 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] accel: ethosu: Reject unsupported commands
Message-ID: <apCpSiXe8gdpyjHy@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-9-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-9-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH1PEPF000132F8.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB398878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8c51a4-7751-4312-7801-08df04808b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|23010399003|4143699003|10067099003|6133799003|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: U6DFIdShw+5EOaCZnmcX9WSKLUMmsnH1URzrmcp8PGhbsr0jMGflDb8iVzxexHwN8a90qUdPKB1GXCzNykUCkakmTmsJlsb5j0bPLlhSBpvjeDqCgKLIj9+LKNsbl/K9kG5Q09uqvcrHyarPogxLgUaaeROeReuIbDk5FTGIFi99zIQ+Mt/pZ+anRqZQC54hZObBfSHZ4tfDcqhDbk4sS+lDjfsUmyQaVnhmxeOgzT/0wyalZ7qe7ldbHFIAkbusUi7KQmBlCGULDvXZYYoBWbVkfqzbVLE/5X6G4U2cGov52ZtH51X+WZrcGZwtn5JuQBc2PjAi7Qn+GAlA5fiAh3PR0ycXXlNwVIctZcwp1HX9Mjhw7CBTKFHM3kJ1OOhkwSjxpIjiVXIQJtKQvZPESyY9KfM/MUbwAgxuzhfKspfNgqlsZ2Uu35QFPz4HhclSGjTVcDk23iMl/GpsGNqsv0Pz4vU1SgWQ5pCdQ3BcUkJKi2mN4BLCeza67aJncEeplcLvVYWpi0SHBLoPKf6qBQ+kmDP3qdihhgHToR87h+1qDOA02FpknZ/wfNbK1rg9gIclCd94/FW/eBkEvgiNMC7NP1T/6RIREcVsY+gV1O/5ncxuYePhoSQDkePktzqOfwXzcTUBSkxs68d9VcEKswptFKUeVcmajJdPncC8/Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkcNudHSBIiEnX3GFna59/29/ThIAvBBCkKPVch4y4LrJ7CujyJN/FasnyUM?=
 =?us-ascii?Q?fgLuhmDiLL3obkkBF36rmmbiavN6hZjn6XS+Xv2dBj08Kdbi3GrvVki80dJW?=
 =?us-ascii?Q?pneTx8yW4JnPE214OfxkbdaCzKlZ1pQ3AkM/iuLbpy+//0JD++MvH0xGlPJM?=
 =?us-ascii?Q?enKZt+vExnB9D3EfFhBY9AZ3Ps4oMvIFSil8AAIMfR1UpSj1U4WuXakk50Q5?=
 =?us-ascii?Q?80j22Kk/E+qJpddgidnNQzN7InMs4K2GO/An00GaPiC+3VGn5G+WmJQahD5R?=
 =?us-ascii?Q?8cc6bSG7ivVHVlcTv3OE4Zlgker5+v+GgfxkaUdI1pUiCLces4Chkld5dTMR?=
 =?us-ascii?Q?yolmBDRAXy9eVQijV+zCCZwlKHmRiIrrQMUUWC47k3690prRXgso8RuJwqPM?=
 =?us-ascii?Q?SmC7G3NTBWYPcMXy78E1UTVlzMWMpE83gdQiREZiF9TyrAOykF9pWHbh0j1j?=
 =?us-ascii?Q?f7tnviKb4CY6C8kvNixsoQcodypddhl4ZoqEtk34cdWiStSGsX5nUYPehR1+?=
 =?us-ascii?Q?4V0KubCqkXK+GXXfQAe5IfpHVhsBsBmZ8cWr64hc8WtFaJzrLBg2ncW6IazE?=
 =?us-ascii?Q?RVx+9k9ZzUurm3IdwjJOoyX9JZ80C0xPptGo9sMYGzGN/1PmNFXW0w2d38Ea?=
 =?us-ascii?Q?9wOFJ2tqnTqm57kUYCyrZ2d7A4vPyP2j5dKUv7d8GoMJ3/ILriqGmAuzYSq7?=
 =?us-ascii?Q?X5hyeJ6W8F/HFtFIycPOzg0IHfX4flfAjCHCLWXJyYIx7As3832S4P524kKs?=
 =?us-ascii?Q?zoIwT875g8Ej3Kn4F+lf8BoPFKP4GYJ4u3X690vK4lY+Qpu/AlwBjOqJH2WH?=
 =?us-ascii?Q?oHyfVoLUmeqfM378HPhKpGQSfP6eXYjWbbGcWpZ01VNr4c+cGEfN7x8LfHDg?=
 =?us-ascii?Q?uR21/h+sxJM/+L7B6nsslgtbgnOt1s1Grj5nccLV7o5QSlYfgRf5dV0F75B7?=
 =?us-ascii?Q?R5o1t1q2L2wPuJGTkMnuZ3JdgBQz0zZK8OMMavb081SbBGdQPuQUCxgyyBDC?=
 =?us-ascii?Q?eQEytzbDn/6XfymUxIci5sf2u//3OHTXvo68g9oqvEoDGSaDMJveaj641UUR?=
 =?us-ascii?Q?HutNzqZbPRVlX/aPQflxkl5BnKf77x7Ib5DmcWl4ZZqdE+AnbpYR68LZA4q3?=
 =?us-ascii?Q?9YMOabbonL9azmHv094D4uas5MnOBJDkDqHZTm8HL5fwv+l7TE7gsDZxt/2s?=
 =?us-ascii?Q?I8rwZqqnt2ccFw2d5n8F8ETbjTtNL0iaeVFS/cIz56RZgRx/Sm+OuT2W620x?=
 =?us-ascii?Q?ILOpvPEWYc+lSj33mlhZDx1b6fbAllJ04TaakkhLAojlNhhO0CCnd8X7MPl8?=
 =?us-ascii?Q?oPJ4Xj5ZDXvg0Vxzdek4uMTXTEqf0DR3TGChb5V+S72I2TjwQuKE7GmU42Y3?=
 =?us-ascii?Q?r9xALzdaog0UP57vxf9wu8hnFQyTNQgAS7XZtYcrVjp0Y/h/pAaJNccHJTaz?=
 =?us-ascii?Q?CxhPaQrSRHqTMvvHYPL3m0m+1f/I07ztXJ9joT1Sm92ss/Zz2JJnnXkCRWOP?=
 =?us-ascii?Q?zRj7M3QtvN3JyibIPimqO0oQmfqb+bJK117EF4y5AOcy/ySpegO4hSyfme/h?=
 =?us-ascii?Q?gxuGHVTIrUWn2Ihqp9qsYzHrg53du3ZPQEMS0/oX1ePdZxzBC4iDm7kyLXi6?=
 =?us-ascii?Q?EMGszEJZbC/jYhgNuR7a7BpEx4fPnRc+WC/rA8ANbwBf5mbfc7/wR/ZzW9Uw?=
 =?us-ascii?Q?nO1ygc9lu3Sl0KySyn/yz9yymOQcqIC2/BsYCnkrX6Ernyi+NMLcXO4VNdK7?=
 =?us-ascii?Q?fRDauPYiAx/73WQyLRpIE1fnVOtlbVWd3oewRCoF0gw1cSp5w154?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c51a4-7751-4312-7801-08df04808b87
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:17:05.5511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZs58s5AQSLTbgnMDyI3A9FFv6Wrj4T8SiBEzaZluunhnUEcIfG7uaRvH0jYfgnbs3OafiexLJUpinpHDkfHPPXP/X8XGSh0hMtBb1F21FZ8y9QT1xMqHnfldY8EIWmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB398878
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

On Thu, Aug 27, 2026 at 03:33:08PM -0500, Rob Herring (Arm) wrote:
> The command-stream validator does not model U85 branches, indexed DMA,
> or OFM transposes. A branch can bypass the linear validation state,
> indexed DMA accesses an unchecked index buffer, and a transpose changes
> the feature-map address calculation.
>
> Reject those commands and configurations, as well as the reserved DMA
> stride mode and feature-map formats. Reject command-stream IRQs because
> they can signal job completion before later commands finish.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_device.h |  4 ++++
>  drivers/accel/ethosu/ethosu_gem.c    | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
> index 1eca8590e68d..c330048dbcca 100644
> --- a/drivers/accel/ethosu/ethosu_device.h
> +++ b/drivers/accel/ethosu/ethosu_device.h
> @@ -86,14 +86,18 @@ struct gen_pool;
>  #define PMU_EV_TYPE_CYCLES	0x11
>  #define PMU_EV_TYPE_IDLE	0x20
>
> +#define NPU_DMA_REGION_INDEX_MODE	BIT(11)
> +
>  enum ethosu_cmds {
>  	NPU_OP_STOP = 0x0,
> +	NPU_OP_IRQ = 0x1,
>  	NPU_OP_CONV = 0x2,
>  	NPU_OP_DEPTHWISE = 0x3,
>  	NPU_OP_POOL = 0x5,
>  	NPU_OP_ELEMENTWISE = 0x6,
>  	NPU_OP_RESIZE = 0x7,	// U85 only
>  	NPU_OP_DMA_START = 0x10,
> +	NPU_OP_BRANCH = 0x4100,	// U85 only
>  	NPU_SET_IFM_PAD_TOP = 0x100,
>  	NPU_SET_IFM_PAD_LEFT = 0x101,
>  	NPU_SET_IFM_PAD_RIGHT = 0x102,
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
> index 3d1f4121db4f..2aafbfe95a8c 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -450,6 +450,9 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  		}
>
>  		switch (cmd) {
> +		case NPU_OP_BRANCH:
> +		case NPU_OP_IRQ:
> +			return -EINVAL;
>  		case NPU_OP_STOP:
>  			if (i != size / 4 - 1)
>  				return -EINVAL;
> @@ -522,6 +525,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  			st.ifm.depth = param;
>  			break;
>  		case NPU_SET_IFM_PRECISION:
> +			if (((param >> 6) & 0x3) > 1)
> +				return -EINVAL;
>  			st.ifm.precision = param;
>  			break;
>  		case NPU_SET_IFM_BROADCAST:
> @@ -565,6 +570,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  			st.ofm.depth = param;
>  			break;
>  		case NPU_SET_OFM_PRECISION:
> +			if (((param >> 6) & 0x3) > 1)
> +				return -EINVAL;
> +			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
> +				return -EINVAL;
>  			st.ofm.precision = param;
>  			break;
>  		case NPU_SET_OFM_REGION:
> @@ -599,6 +608,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  			st.ifm2.broadcast = param;
>  			break;
>  		case NPU_SET_IFM2_PRECISION:
> +			if (((param >> 6) & 0x3) > 1)
> +				return -EINVAL;
>  			st.ifm2.precision = param;
>  			break;
>  		case NPU_SET_IFM2_REGION:
> @@ -673,13 +684,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  			break;
>
>  		case NPU_SET_DMA0_SRC_REGION:
> +			if (param & NPU_DMA_REGION_INDEX_MODE)
> +				return -EINVAL;
>  			if (param & 0x100)
>  				st.dma.src.region = -1;
>  			else
>  				st.dma.src.region = param & 0x7;
>  			st.dma.mode = (param >> 9) & 0x3;
> +			if (st.dma.mode == 3)
> +				return -EINVAL;
>  			break;
>  		case NPU_SET_DMA0_DST_REGION:
> +			if (param & NPU_DMA_REGION_INDEX_MODE)
> +				return -EINVAL;
>  			if (param & 0x100)
>  				st.dma.dst.region = -1;
>  			else
>
> --
> 2.53.0
>
