Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB62FB5E85
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD1A10E40E;
	Mon, 16 Mar 2026 22:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YAhtD/nN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C8910E405;
 Mon, 16 Mar 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773701491; x=1805237491;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=85JAHi8ATmlxbsnv4KiW9fI1c5GG6nS+sF1/WsxsrRM=;
 b=YAhtD/nNNqKRAMWstH1zZ3DuK796crGR5uQhbv6/HbFrRaS7spuMd22S
 I7h9CXp2WdH+FAnAJeo4vyGhxnHheHbWB3e8lYoeucb4oZHxwtqakLOZK
 m629Ay3o9D2US4ug9JkHa4avdvyzNMQ9MTLFj5qP+qyuDxxUPG8U1IHIV
 Fowb8NU0ToXLsKVD9qia7Br12Lz+ybrOwdo/IKRmNt1FZm43LazYh6QcN
 JymUps5Om44ws87LtfwIzQriRZcGYa1gtfmb4cuXRK79M6U8a1xtFrgN5
 PFQnvFOtyneLEDOVTaQTjDNn21BAV5yNXujZ9lg+BO8NyIU2oP2K4bQyh A==;
X-CSE-ConnectionGUID: LND9MrPXSVus2qDyYln7Nw==
X-CSE-MsgGUID: cQtgU5HWR66MseAmtifC/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77338488"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="77338488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:51:30 -0700
X-CSE-ConnectionGUID: QSqz4hE+Spyxrp3+5ije4Q==
X-CSE-MsgGUID: +6VHMuucR3ax7b1QGgvV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="227046920"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:51:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 15:51:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 15:51:29 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 15:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8+hm2u5ZxO/+rTAGsYB5abDLUdTOciGMO58QRjror9dcPONOJ4wbNHDlGzV4pijPB8vvyxckSIPBmbNUmtWZMgNSAd62S5pjblScqzj+ptLekUGZT4NU8onVqPbrYX1ZDe5/0hYnpZwb3f9C65GMM0h/yipMD1z0H0NWe9wHi7cvMT3AY9CD2+YDHePHmxNQst3nSHXKGzsBwbzCwmzv6MO81hASBzhc/sYuXXex0nJGl6HCTZUOiAnvImhPtgN7/zALrxPg0vFPT3Kkp2AZWHBKB9uLpQp8golkK0koXZO8GRZJ37l5fTIq/PE+xDEiDza8191iBKZ8wpeTEv6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYPy2aMntl28ycbPGCuA0++IhaDxS+b3Q87YUTiCavA=;
 b=LCfFfShz4QAvve6OZid1BD7+rkyrV0P4TwlkUcFFnTfZ0OPqWa99p7ezmb7WJFTpMhdYzqd6ZrG44rxnEFG4YZ+OSEb0/DkCtiHQbM23+uX2btTuLz2XlmDgzAJTQCWWjSB2X4W+i7QYS0wSCB/9yXskZkKyq3PvELohPN+/6k2skkmxQJrDZggZ1SONqZIaIf/0juBchsNQ42hMUxgtpehDB6FXwSPRnnh/FiOdiD+mvS2NIz6DWHCU7xShuCJMlKkl9xigYkgsMUHeqJLy9QzKKfDyadqlmbFk3MFbID2MHDN2fCrNobeVWfk3sS1sPRakspy7Ozl3WnmkAp2dCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 22:51:22 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%7]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 22:51:21 +0000
Date: Mon, 16 Mar 2026 15:51:18 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Lucas De Marchi <demarchi@kernel.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, Umesh Nerlige Ramappa
 <umesh.nerlige.ramappa@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: use %z format string for ptrdiff_t
Message-ID: <20260316225118.GD2729713@mdroper-desk1.amr.corp.intel.com>
References: <20260316224357.658520-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260316224357.658520-1-arnd@kernel.org>
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9badf82c-2d85-4cdd-6dbc-08de83ae8b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KAeGV8JyAAtMhcb2ML/v5ZPVcye4Twt6yJ5VSq1/wVFZY0nygrfU3OPc1zaC542U7qnU5rffbbmlPLiflH0zAetpRKhhtykuYyXn/DxInzLNtx+QY+4cDoobySKp4hx2cdogCR1p5+HjHh1lfZnZfaTUDeOYSReHQN77os/m6tAALI7J0unVCyG/qmGudaVL2kSy4+xIkCud1CgUX2a47rMVe5Im1/0sqAOJ2lD61mpFnVNb5OuMhm4+qh3+n9NcVazCPHlneEFcQE3FgLDLWhf70gssd6J1PcAnF7O/iveec6juIGYAGFx3n+ZKyKwxw7qwcDMGO3B2bo73IEKdExnlYgVRSX4CXG4QCmmAOIsnqlK/1B26jnV/rTXCjRQQicIEDZ8ch/kZ7T94zk9ElGdQb2urU1h2M618/xiOEP7C60xdQXRsf5eD4GiWzUiEy8b3geAURV0dZapOGEpd/CD5N/590ANqrn/HS0HhtW2RFM05zZRXqn7CbN6obOVev04l3GqAG1XREC8+pQBjzNnJxLn/ufWnsLDY/yxRgVYsLVA9CliU1t9AkZces/c/axuJtN2Gc+ITMcZ+TGoL4KY5OeiB628J0hXypKymCWyaMr/YyFNbl7ghnDpw5mK2NSCYJiuIpm9XT8LTkZniqhFvhDPlpg64pRpESO1wlHuIZMlWA+B0lCeqdsqvxghko2KSe64mfp6h80o0kTeWSn/7U6+HrL9BJ9+UlDuW0+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAG9Fkaad0FEtVlPK6r9UGNmuMWMTmxUb28AQzCmSvrbx7Iw2UjkmfLxiLFm?=
 =?us-ascii?Q?a3zlljl7tkfsTnH+s96CJwY89exrRXdhTbpzCcmHLxpCnL83EZsnolBu2Zup?=
 =?us-ascii?Q?48EP1yhHnZvFeG+OQw9nIAQrDeAqurQhAzQXCVkF1QAT3oMYi/yK4Mvvhh+x?=
 =?us-ascii?Q?L40AuiwBlvrSevA8TDHHsweB7df4iMjVFChAzhMOwIXeBzr5K6kFoxtPc+hx?=
 =?us-ascii?Q?bl8YraineIiFwbJvzlRk4Id1NTRMBW3qBoT0N0jd48XMK/YVzh5Fcb2JtpGI?=
 =?us-ascii?Q?CdBqaLNrUOu8+1PfLwxhf6V/cGOGoJW7P6hJqzHlPwW+cpS8VsuQ7EO++bjZ?=
 =?us-ascii?Q?GknirKFQPmN1znSDpsr30c3wLBqxb9CNKUjJzlMca7UQhzme2yCZ/NVqhOLE?=
 =?us-ascii?Q?cuZkstHF1f7hc9B1zlt+oKuLgFJuKh0Q5xenw/RjHLOjUmU+UO+1Aghpa7/9?=
 =?us-ascii?Q?auUmPGNfc9QnKgVCoNqCs4Bb5aycs8auaUKidpdg8CuTg7PbYlB12yZ1K12/?=
 =?us-ascii?Q?E0sLdPlp3mebzY15/ZD4MxxgVhRgwMuPtNtXo5YTjcEHUtRjiBUoz4Xp0VZr?=
 =?us-ascii?Q?iUius1H0mY0PHUy7OHLakBtkF2u6asCNnxok6pogQvrjysnvHAr6iK4pwRCf?=
 =?us-ascii?Q?JVcAuB6GOtSgdqtphx2V4mDHe06v2W6z8XuvKSkrXdnmsaHpiWgsFE6q+5tJ?=
 =?us-ascii?Q?9tUlNURWEeDb0krdkqAcLOBxe5VmmJ/ox2PXvfytzOCRxRQpkTwOl0E5JSAI?=
 =?us-ascii?Q?BaXBBQ4w+10tNRqcOYX53xFSP+awdkkFahxhSsTf/3qFpaKvfyLAW+QuWlGX?=
 =?us-ascii?Q?86Kqikz2S598e1j4RrNYuWjjxg8uit+jSRL9c9jsr+dPYyZ0MLO2n/g0qHh0?=
 =?us-ascii?Q?Ip/ZNiysbLnOVBRn8IifZA7eIJ8y/AqzuJ+M+PJDrcOLbgy6jxOHzB5mYqeA?=
 =?us-ascii?Q?ieomAZQzixBtZk+cCwyuZeS9qZ0fd/DKtyMovdEN6QPVvAJX7jlEkOSmxSc4?=
 =?us-ascii?Q?tYMy4gjR3GPQ9/wVXWaR3xX8UagLc+mUrnG3uSEMDCFKT+luVj9k6eV3E+6t?=
 =?us-ascii?Q?1TEdyUkWbR/o7m9gZ6VyzmqkIZmwqjcadhR7qmvSDXKRXwL5gU9tjzA4Hwvq?=
 =?us-ascii?Q?hOgYjXNMh3ZI97IaqlUGbi6n69WVkUvPNML/S9mK36fl+HRzArnXAVYp5XGT?=
 =?us-ascii?Q?1EqxqcALxPw94j/k1P7LMzlYIbXIhlKfWWApxOA6DkCfeCuM9PWZiFy2UudI?=
 =?us-ascii?Q?vtzKVYB9gOhyOd9HtLAYiSnTt1X29z/5ThpetbkvB9Kd3tTODyFAAmG80c+w?=
 =?us-ascii?Q?3Kkpw5lAACsA2nkvNxiiOjknx61Q6Rljd2iSaWHJfTALc7/unY2n1OPB9CTp?=
 =?us-ascii?Q?ckYsD+Iu7QRID6EvBnmOc1kNBEFs7VmTGXtJC1TURogIXrYxtXUy1m6Mf7Jw?=
 =?us-ascii?Q?EtpoGXxcpcDtPGIPWYkxEQ2SHExcR/wAPHl0IgQTTCXaw9z6F7BgCFmROCn+?=
 =?us-ascii?Q?tYlVe1rtWhfxYy52lLNsA1+H/Gw+HehqYGSAzACKkxM04t5sJhnWuB/b96u/?=
 =?us-ascii?Q?J3QVB7+SIV/1GB2BIeIa4ONOu0n5FwQizqJ6SfyJp1ojdALUv2X3sP2QGzmQ?=
 =?us-ascii?Q?dLivnpXWGXXEkc6LyN6zwyR98Y/kEPV1Dwaskj3XttbuXGd60v0uXV08q88x?=
 =?us-ascii?Q?mSknXsPBwF0bXpgNae93sIV3fS/aqOYNeCkVKeOCYJFR6xmwuktxoFpYzjv7?=
 =?us-ascii?Q?0G4phvikZvMGTbONw279wD4LbirgTGk=3D?=
X-Exchange-RoutingPolicyChecked: bz+4zS2ksxgtMrzNCRiJ2L+cm6GWDx6ykQdV1I2W8efR0ODJ10KSFWhNr3HWJdy5aN6S9OaA1XVTHTb18o9GyCkBlVYVcx6hCvqR3qCva9UwRHtkGDkTNveG9BfisB/eE5n66ge7id888YO+8I81V5+LVY3GwClI59ms9ZrMzSywt/hYuPlippngVO1tLdLNug6aGWfqOYVm8bHBotOoGtosIIZZAB70TQ1DjVryQpPrOa/mlMMTWQ606qCdYY+7on+tp3shpyWMeNe4SxYkx595UTo7jqQMNep5X0icHnotSfWw4yHZxnP0+e5NL69XATUPBZB9Pb5gYQS/5mj6+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9badf82c-2d85-4cdd-6dbc-08de83ae8b28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 22:51:21.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZKW3PHrjMIU8NpoddsBfEC0X+NMQgCduD1iR0QfeTuTvc8tNx4qQsUuTtzlCCuxkJPOBwkR+opdKJwQYWCx9l9h8/gTNf5jon/fHIZ2zdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com
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

On Mon, Mar 16, 2026 at 11:43:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ptrdiff_t, size_t and long are the same size on all supported architectures,
> but gcc requires the use of the %zx modifier instead of %lx. On 32-bit

Nathan Chancellor just sent a fix here:

https://lore.kernel.org/all/20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org/

His solution uses %tx rather than %zx, which according to
Documentation/core-api/printk-formats.rst sounds like it's probably the
most accurate format string for this case?


Matt

> targets, the wrong one produces this warning:
> 
> drivers/gpu/drm/xe/xe_lrc.c:1913:7: error: format specifies type 'unsigned long' but the argument has type '__ptrdiff_t' (aka 'int') [-Werror,-Wformat]
>  1912 |                 drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
>       |                                    ~~~~~
>       |                                    %#5tx
>  1913 |                            dw - num_noop - start, inst_header, num_noop);
>       |                            ^~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 65fcf19cb36b ("drm/xe: Include running dword offset in default_lrc dumps")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/xe/xe_lrc.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 5ab088e5e13d..c528818e8853 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1909,17 +1909,17 @@ static int dump_mi_command(struct drm_printer *p,
>  		while (num_noop < remaining_dw &&
>  		       (*(++dw) & REG_GENMASK(31, 23)) == MI_NOOP)
>  			num_noop++;
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_NOOP (%d dwords)\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_NOOP (%d dwords)\n",
>  			   dw - num_noop - start, inst_header, num_noop);
>  		return num_noop;
>  
>  	case MI_TOPOLOGY_FILTER:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_TOPOLOGY_FILTER\n",
>  			   dw - start, inst_header);
>  		return 1;
>  
>  	case MI_BATCH_BUFFER_END:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_BATCH_BUFFER_END\n",
>  			   dw - start, inst_header);
>  		/* Return 'remaining_dw' to consume the rest of the LRC */
>  		return remaining_dw;
> @@ -1934,35 +1934,35 @@ static int dump_mi_command(struct drm_printer *p,
>  
>  	switch (inst_header & MI_OPCODE) {
>  	case MI_LOAD_REGISTER_IMM:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_LOAD_REGISTER_IMM: %d regs\n",
>  			   dw - start, inst_header, (numdw - 1) / 2);
>  		for (int i = 1; i < numdw; i += 2)
> -			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010x\n",
> +			drm_printf(p, "LRC[%#5zx]  =  - %#6x = %#010x\n",
>  				   &dw[i] - start, dw[i], dw[i + 1]);
>  		return numdw;
>  
>  	case MI_LOAD_REGISTER_MEM & MI_OPCODE:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_LOAD_REGISTER_MEM: %s%s\n",
>  			   dw - start, inst_header,
>  			   dw[0] & MI_LRI_LRM_CS_MMIO ? "CS_MMIO " : "",
>  			   dw[0] & MI_LRM_USE_GGTT ? "USE_GGTT " : "");
>  		if (numdw == 4)
> -			drm_printf(p, "LRC[%#5lx]  =  - %#6x = %#010llx\n",
> +			drm_printf(p, "LRC[%#5zx]  =  - %#6x = %#010llx\n",
>  				   dw - start,
>  				   dw[1], ((u64)(dw[3]) << 32 | (u64)(dw[2])));
>  		else
> -			drm_printf(p, "LRC[%#5lx]  =  - %*ph (%s)\n",
> +			drm_printf(p, "LRC[%#5zx]  =  - %*ph (%s)\n",
>  				   dw - start, (int)sizeof(u32) * (numdw - 1),
>  				   dw + 1, numdw < 4 ? "truncated" : "malformed");
>  		return numdw;
>  
>  	case MI_FORCE_WAKEUP:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] MI_FORCE_WAKEUP\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] MI_FORCE_WAKEUP\n",
>  			   dw - start, inst_header);
>  		return numdw;
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown MI opcode %#x, likely %d dwords\n",
>  			   dw - start, inst_header, opcode, numdw);
>  		return numdw;
>  	}
> @@ -1989,12 +1989,12 @@ static int dump_gfxpipe_command(struct drm_printer *p,
>  	switch (*dw & GFXPIPE_MATCH_MASK) {
>  #define MATCH(cmd) \
>  	case cmd: \
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] " #cmd " (%d dwords)\n", \
>  			   dw - start, *dw, numdw); \
>  		return numdw
>  #define MATCH3D(cmd) \
>  	case CMD_##cmd: \
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] " #cmd " (%d dwords)\n", \
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] " #cmd " (%d dwords)\n", \
>  			   dw - start, *dw, numdw); \
>  		return numdw
>  
> @@ -2127,7 +2127,7 @@ static int dump_gfxpipe_command(struct drm_printer *p,
>  	MATCH3D(3DSTATE_SLICE_TABLE_STATE_POINTER_2);
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown GFXPIPE command (pipeline=%#x, opcode=%#x, subopcode=%#x), likely %d dwords\n",
>  			   dw - start, *dw, pipeline, opcode, subopcode, numdw);
>  		return numdw;
>  	}
> @@ -2153,7 +2153,7 @@ static int dump_gfx_state_command(struct drm_printer *p,
>  	MATCH(STATE_WRITE_INLINE);
>  
>  	default:
> -		drm_printf(p, "LRC[%#5lx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
> +		drm_printf(p, "LRC[%#5zx]  =  [%#010x] unknown GFX_STATE command (opcode=%#x), likely %d dwords\n",
>  			   dw - start, *dw, opcode, numdw);
>  		return numdw;
>  	}
> @@ -2188,7 +2188,7 @@ void xe_lrc_dump_default(struct drm_printer *p,
>  			num_dw = dump_gfx_state_command(p, gt, start, dw, remaining_dw);
>  		} else {
>  			num_dw = min(instr_dw(*dw), remaining_dw);
> -			drm_printf(p, "LRC[%#5lx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
> +			drm_printf(p, "LRC[%#5zx]  =  [%#10x] Unknown instruction of type %#x, likely %d dwords\n",
>  				   dw - start,
>  				   *dw, REG_FIELD_GET(XE_INSTR_CMD_TYPE, *dw),
>  				   num_dw);
> -- 
> 2.39.5
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
