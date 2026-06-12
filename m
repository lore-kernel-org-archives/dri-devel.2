Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0336CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FD510F476;
	Fri, 12 Jun 2026 12:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mgN4V6lu";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F2A10F476
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4f7Xh7lsKuTdgLx1fNpXbzbAUYvkv1YGuYzGKw5AFXEB47I4C8pWgKirGC5Y846tXWqC7FuFPuPolqRqduljbBa2GMrPzog9P5hZi0c0TMXjoRnsIenjc6bLjFLBOKTW7ryT/UgmxMjOcBbiWHYV7RjemiLyywaaMrKnnQwyX/GWZdbmC+ZJn8/bLLt6hzYrEkPAEc7esKPinrc0aQm4sNO2XqV0KEoydjhP4ZJupe+3xOxk4hStRrqboVGM/U4ZZKQAn9FI2w1ioSSudMfj7UoSdlEdCBgUGFCbmGHYxbMlPTWEmV27DahT+S0OVcilnurjIU6IkuvrRxlVI5Ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCO5Hq576g18n9P41oQFhtFzKFxoP11El6ls8DDf7T8=;
 b=JnWJOEk55ZSWSw9tEgfxY6CmfHH+zTZPdSq7E9YIjPxxsGlZ2S6Q83UoKQFBC5XOU2UuTPLniWcM1czWNe2rGzC36PNZPYT9c5vW5ixgTgo7ZXOZ/U5i7ZpaeC7qJd7SX7tLiYMcuykEZrmi9NYswV5A60dNCFsvUCeADA071lk6+XGyLuUjJxwOv2E2mqKBINllLiEC83byHM9rCbFFOJFjb91YBVFwus2MtQpdiI/X+Z0iJGpkaErRzYKULjKQWepfujqBTXU+y0NtVuZyJhIPFf5yGjzgWOIvOXAQTVaK9L+53cCVevuMVp7C1zPbfw1DsuyFBHrMMx2eQ0X3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCO5Hq576g18n9P41oQFhtFzKFxoP11El6ls8DDf7T8=;
 b=mgN4V6luqekFjs6XyWID8RTDhO1+gQ2kvpNFUjHYiduW5MYaLlKbY9FHRdOkNCkK3MwcTZGV18U5p2Jm4tZaIdh3fcIvmWHWPEWfk4NVYWc8h9qLBBbqJilLhhshooKlkyZBZW3HCLpUktbj29zfsS/oodL5BG0mlrgGIsN6olYzQTF0cOti+DUiiqj6clKBxHCxeFrwDsbFdbdlFLfzTWSImS/UYedg6QsOzU5CZA7p6rTPbhjhTsH997cIg36XExv9WaB58nsJ3/D7lLZxBKLHLAiY/MrC/cMbgiTiBhc3c1/P3k1JWWgJLy2wR3VN8oU0vNNCrCKN9G6FUG+FRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB11338.eurprd04.prod.outlook.com
 (2603:10a6:10:5d8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:02:51 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 12:02:51 +0000
Date: Fri, 12 Jun 2026 15:02:46 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] arm64: dts: imx943: Add display pipeline nodes
Message-ID: <3f4npknwqxamayxjbljvobxivspxh2w33izrprcvsun5sdbtij@twqeqgrfksdo>
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-7-bec5c047edd4@oss.nxp.com>
 <43be372e-8177-457c-9d4e-a2ed69e79c8a@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43be372e-8177-457c-9d4e-a2ed69e79c8a@nxp.com>
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB11338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afa2c0e-b624-413e-e43a-08dec87a8720
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|7416014|1800799024|19092799006|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xGOfio26wDEZfKbmye9mu0ZWBLfB0LKFsIufi47v2W/hg+gbFxflH2Np167Znb4/BpvNGcrDRMvZ8X0xsJN888VPjOdM4xjh0wfpUyAc0WYHJ8SNokJHEbmx8s3QglRL73ez7DfnZxryYKsj4z+D+/vh7J+BtaIRIZIeE2aR6+WuGrxkm8aRBtRWvUB22KSl3iSKfCinvpR7bBDRySfFLbSoQEVDim/8esiee14Pw+JgcoFqylDcKibfFmeHns+USxZPnnrSlvDv/ZyNscMyyfIkqK4xetJ8yJ8NYt1o+8DAH0v2VJagNqsdiMkJLoua0hiCpnfVW0DO57h71+H1UuhnPcUpDrzDR+tuI6/SQ/Xl60ELZ7psE82u65YQ/CMAPcqZ0Tu4OxxY0KYxG5ITEfqnQXoUKSjPyFS0KaAHtleVycA3RxgpzeQMhJG95w7v3L0Y6C44VCCi9WV9179+baCxDYefKDd/b3ZuHi5MlXp3yrFt9M4HsMiJi5m+i0DUar4dCVzrTaHt/8Nt9DfqFl/hiAX7RGQ7q7xSwwPvRU9rDNAcChfqc9j3mYhowvZboNYvtQruM2kfPUiGwYOwuBNTvCc8/szgeLW2497UDKC8dhnXYYSV/AJ9gQng2wFOP9GwyI+Nemj7fCsp5RfoKP+E7hWqGEMY06KEpP9eXqzTUPqF7CsE2I25UgJ5uSX7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(19092799006)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1PHpKH5tSSs6hf1VHGxhjzJCOC/bjup/lYhPQVQYvP/cqvrpGRUMJFBKeOO?=
 =?us-ascii?Q?LmrQICM3y3HS1CmPq/fqrSD/FYEEqOivx0QkB/jVbHg54sfjvSfvpM/J4HaS?=
 =?us-ascii?Q?dPH+BhLaR4KO5oeRLbYgETbfYUhL/8nyZzOL+oQsD+3xzkqhXmrsQPtencQ9?=
 =?us-ascii?Q?ObatKzGXD62fzUSZb+ybi8cKf5UhUXJNRpKXlhWUJ6VU7YIPzMzmJ76iqAgG?=
 =?us-ascii?Q?W9J0vcCJlY6vXZR6iGIbJFVy3qrbkgrWDR8IjlUMXd8dGnqThjKxsRHGKbQf?=
 =?us-ascii?Q?5b+6ldRBEGIH2SUo7oggfPyKKOPnDd42acf9JbD5aokaRB00YuBGdAhTizG2?=
 =?us-ascii?Q?uQpPed3Ul/MCc5vcM0MbqkmM5NRSJ/2nLx42pIBvBdcChwoBJEfoSdc5Egkw?=
 =?us-ascii?Q?sbPxOsvmQM0zUAG78pS5vYiHwfjnHi8S3qz0/DZVXKCMgMVCDL3SaTZJp+xr?=
 =?us-ascii?Q?M73wHdoRI0W+Z795pFuVifC3Ykd/vKIVEiTHY1u/2pF2nsm9egWArnxgeK/W?=
 =?us-ascii?Q?3iSEmVlfuKqrptZTkY3/iebxegfGfsVzgSNiLWrCtbHi/W3qRO7yLIEY2VSU?=
 =?us-ascii?Q?0v2Dmvscc0SwWxUxh4JLZOBou2YO/ytFmxLucnePBK5GfgF18Od5cJtSj1kW?=
 =?us-ascii?Q?9VKUOtB7Luxt75/Ky3sL1xMjrLFlRUy7S5W68U+rypmKW4jsthmaMNw8Xs7s?=
 =?us-ascii?Q?8v+ta5xD0aHWeIpIEf5Qs8eRPzQbAOM8ZrbVsJ1REoDuI/gWx8JDj/ZN2yfd?=
 =?us-ascii?Q?a4604Zp5QIEEY1e9eUq9vRNjo/4G7B39c7f0pvpFTyCpMl5nhUHHf9Kvk4t6?=
 =?us-ascii?Q?Q3hYxEUYAZ/spCNkT0oXAiCCvlg7uzmdfYurhLHKk/HOyKymxtgoAGuUyS4w?=
 =?us-ascii?Q?g85tC3FkPhuUwM0UXiHi0dWRztNJ1tvDiP6vWAsAeFjRwxaIjDj1F9U+hv3e?=
 =?us-ascii?Q?13kJNwR+fNtBYpWHmUMTjWwsSSG090cmDSM9Xg1P39Yk2ioPg5jtB1GF1U79?=
 =?us-ascii?Q?EZi0q07+YnC93BwK82w+AOJ8SNqH+Zs4iibwBBlTAmj53dNm7PgQHoh3RIAt?=
 =?us-ascii?Q?7FUGAXWUXoaDQyItR7V9lLyHTl/zo/joEDKFUTd4f8xyDG8KjTfyd++rAZaE?=
 =?us-ascii?Q?UrBmTo6KCU3PIrkkD3MHo2LABMM1+xWTjSdv3DdYtW/UHqfY8CjppV5xzjIx?=
 =?us-ascii?Q?9whVLSH+wxXNDPMvMO1EpUzqOZUkJ0YzNIoe+TDgERYCZAumsUSgFedrQ/U6?=
 =?us-ascii?Q?U9qwC37xUt4T5QHY43FKbP9qjqf0S4/5EEGrjGJwFnxgKhpuJDYUt4lff85U?=
 =?us-ascii?Q?5nYweC+eCKQzoObcFvz4Meg1bQQi/zETiovA5RNOp1eF0nKv3ZaJXdcJyQCK?=
 =?us-ascii?Q?e7siu7y6ENupl+2UarshORnhJ836EEmTEuxtLcEQfZaMuh0dIAJygqhIlHEp?=
 =?us-ascii?Q?QtVeQCp8k881/1PXD+mhcVtoqkHxk6UdrxleSwx5ZGsmViab4HY3D/mhHuNc?=
 =?us-ascii?Q?EJYIn61yGl/5NVrB9lK08KdgOtNwhV0ExtaWMHhqzk2MbqWhDCcixyb363YG?=
 =?us-ascii?Q?0Qw5aQCen6duFEKSt+LJCj6rJKoY0WUUnlL+/FU6RRwT5mDMScEWcJbiEUMM?=
 =?us-ascii?Q?eR7skso0F6kJKBfnuZR+Jh5rpCarKnVfFL5wxi9sOHvlNGgJ1nc+hpltneVa?=
 =?us-ascii?Q?0ODb38RbrPDoeY9K0+IbBJkmQlkyUVkoPBpM4CHD9L97yvlRtm7WS1IockOo?=
 =?us-ascii?Q?qKST33UuMq0vNVABWEGLSPoYPyx4fk4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afa2c0e-b624-413e-e43a-08dec87a8720
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:02:51.2839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjEO92uQYCW/0EhrbQPVma28dVY0IFCJe9kXw9b7Iz4RamqESPbp9GaZfCKDVMda28w3P290Yew+8FqBgJjfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11338
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

Hi Ying,

On Fri, Mar 06, 2026 at 04:27:48PM +0800, Liu Ying wrote:
> On Wed, Mar 04, 2026 at 11:34:16AM +0000, Laurentiu Palcu wrote:
> > Add display controller and LDB support in imx943.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx943.dtsi | 53 ++++++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
> > index 657c81b6016f2..9a91beef54e86 100644
> > --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
> > @@ -148,7 +148,7 @@ l3_cache: l3-cache {
> >  		};
> >  	};
> >  
> > -	clock-ldb-pll-div7 {
> > +	clock_ldb_pll_div7: clock-ldb-pll-div7 {
> >  		compatible = "fixed-factor-clock";
> >  		#clock-cells = <0>;
> >  		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> > @@ -174,9 +174,60 @@ dispmix_csr: syscon@4b010000 {
> >  		lvds_csr: syscon@4b0c0000 {
> >  			compatible = "nxp,imx94-lvds-csr", "syscon";
> >  			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> >  			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> >  			#clock-cells = <1>;
> >  			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> > +
> > +			ldb: ldb@4 {
> > +				compatible = "fsl,imx94-ldb";
> 
> Should this be moved to imx94.dtsi, since the compatible string doesn't
> seem to be i.MX943 specific?

Agreed, I moved them to imx94.dtsi in v9.

-- 
Thanks,
Laurentiu
