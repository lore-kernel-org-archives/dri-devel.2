Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1ACCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 20:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093AE10E5E5;
	Sun, 18 Oct 2026 20:26:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7A810E11E;
 Sun, 18 Oct 2026 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792355155; x=1823891155;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2xXcSfTxfuLrD+jUu19iUA8QJkyD0EYK/tIko8ebBJU=;
 b=EQklsbz5O4BNfppzk6rITZ07uwklJaEgUb68bCjidojF/PufUpU6G8KO
 tSs+H/glo0QEkT13pwssIHHGzVUTza4UdruS+D/8gOMCIoVHbwUN7oxtA
 ioGlomZwCnCaZDbcnALfJsW3kK9s6Vbr0/xtcfwM8fnqvtGUoL+JeWVF3
 lU2t0Ims5UTGDy7r5pYK6J6NNkqA70Qh2tVeT/NGp0rWDOX5qIUjvRAIi
 cGW5xc2sZpnU0aP8hKX2p/2og3tGAnHxS8KJNQegjspKt8sCt4UmfNaCY
 Oc/XQClzpT9q6NWkVhGJGF/ZL5T7N3MHKymJZQ5+iLWutiARN6G+6Oo+t Q==;
X-CSE-ConnectionGUID: mk5bAadtRdKSELwo9DisHg==
X-CSE-MsgGUID: H3EU6sQWQDK2GE+KyE+/Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1046590"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1046590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 13:25:53 -0700
X-CSE-ConnectionGUID: 3NXLiDbQT76PlUs3H5ooTw==
X-CSE-MsgGUID: x5zyZ0pURv+6OcPjpgbp4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2260791"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 13:25:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 13:25:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 13:25:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 13:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFGHpXZOIN3g96x4zsRrnHvjY7pBhrcQwC5qzgQF/h9zxA0fkyk26DvtqijvfkbWNBgZxXeuClaOyAkDLdqFY28kX91ICUG/GS7ylv04LgUSeqbyPy4XM06SE1bgRLAtPDLhefAbkhrRqYrW0N5sgNWiQfFKYWlJFqlF25WnIjEdce3AeTZwOSUxrzXJX3RfS/BUuujrPq97WfhVYhcCvfw3KUdUpYgDi0LAgQASzCmO2b28acOBgSqj1jmAw9Oq+IfjR2jfKoH0F6/WtFDLFT02kHbSrsmwMTstM1D0X3d86L0U1DKly4hK2dW7Hp30rLkWvp5J2wNdAtXripZa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsKrB2b/h1zhijfRjDX+7DwodPpFDsums4jDKEA8/gw=;
 b=KMVwPKc8rEmJcGunOX1XtSMIaV3dNYVWgQi91hG+2NhhBTzAyO8dvRrFODKXkPczFpsHfw9gKD/ZKKk3xKXvDwH/gXloFLEC9ruAID4rixr2waIv6zZAz4uSfOEdUNIUAibt0HorNIGNpN2PG8/x0qsC32EgRDE3AIgfDMSSXOU9k2YHNGuRvdYgKu536tGmcvJf/ALd9/PUOjfMJd7I1vJHAsgnecZI7HV2GXHaZXM7DAHgRxCJW/6/UHojTbUWVxvhEemeFLK1mTMO+iDNX9LFALB+T2GBcI5ByQi17s+ZVyvEPdt0I2D2GD7+EfBpN4pPOKpua0AZ9jjrX9BWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 18 Oct
 2026 20:25:49 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 20:25:49 +0000
Date: Sun, 18 Oct 2026 13:25:47 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <matthew.brost@intel.com>
Subject: Re: [PATCH v3 1/6] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
Message-ID: <atUrS6S9cRobihdB@nvishwa1-desk>
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
 <20261014190200.1700470-9-niranjana.vishwanathapura@intel.com>
 <af32a6f6-ccee-4265-96bf-d8508d0127b7@suse.de>
 <atHDszh1A9Eqsukh@nvishwa1-desk>
 <660f7cf6-fd37-4c91-b802-767a11a8dc7a@suse.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <660f7cf6-fd37-4c91-b802-767a11a8dc7a@suse.de>
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SJ0PR11MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 056ecbd2-b434-45fc-fb76-08df2d55ff90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|5023799004|261009223027099003|11063799006|56012099006|6133799003|261009221227099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: kGr5YEowQCAdv1F4vhL9gUtOCHsUvKYRUQwyT2KjFhzHgPVJgelcM7HrdUC229L/8xZ3iw5uriODIfZF2N6KnEwdK7kZDsPybqhUaNMerQIVyWFyH6ZovcyiAw5QCFCM8V8tEkMsPjXJ4xAPfn0rSgKmOQqifNl3DmP6nJgeO9YgS3HeJexf0B2paJaRU5//WjkA1IUEaHWf0iFsYnKl8JTLFEDDCiDa7cQJlw3JTAh43QQeovoxU75qlnZh2TNJy4b/XfdpjkrS5G6VmetviHDLtE+TEvREssMrbjMdqgeluWB8caPuY3m2EgllZL6BwcoIne1+ShVsenCWRGOHTYIHvf4CoE9vQ394Os7oDz08AkCuwXwdQorTlFa/1g3ztBZ8tmeT8/WDL8GIs33vovkhFNeZGPYfTOxjk6iMhdAXQot8/WncAVBCufmSGEx306RXls+0PRo6cnSh8X9AZwictwTHySJNsDh+DpYbxf4WXB93CqDoWelsaUpy0P/6XOa+JlcWPE9qrmKmcSbGsTrcmz86MxBWagV7pjydlu4+RIyejCCEs9ag5VX89DeTY4Dvlc/Fp6QoqduqoE9XhmtLkqEnS0oO9HGyuG7VZSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(5023799004)(261009223027099003)(11063799006)(56012099006)(6133799003)(261009221227099003)(10067099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?omWh/KDIrFqQFM0mDoVPmsSl5qBSlyoWaN3jTywg5EfndEs6B5Z513c74b?=
 =?iso-8859-1?Q?FfY6pifs0GlzdPUqqFs7G1u09dhjfLq7itQogrd8p3sqq9mLIrwKqqPm1r?=
 =?iso-8859-1?Q?Fs5PpTfNxN1h+8RfE6Q2H97d0fHKC9hDCzhymo3+2XmWLFxPSJF3lO3SRk?=
 =?iso-8859-1?Q?6+tyB9bpM2m+WQP7t1jxRyKtaDKAh84VAAKwhBiUduJ1qitpri5tmh242H?=
 =?iso-8859-1?Q?6OGzW6iv2xqZabIqNYpTf7c/rfSzcbnKP1rEGtZ+weESkTApEwVaHt1h+5?=
 =?iso-8859-1?Q?arEmlQWRPLYB5tBBlEUSJNuBO+KxFNgz9X02FsbZSH/SmCSH8RPlTdbXFi?=
 =?iso-8859-1?Q?ChJizC5wHT2o7X7MUNibuq1qRrxG991QDZD2Dko9m+7VnlnhLDshzaeQxO?=
 =?iso-8859-1?Q?0iuRnHbLa3/UUnxoTU7gtaLr25wPuttD2vWP8i5dkNxvGhuFaGxLllpxL/?=
 =?iso-8859-1?Q?fTJ/wv2HQydpB+TxFC6zIoyZnPVRI14GWGZPG7/YIySfhVdNNGng0w04J/?=
 =?iso-8859-1?Q?k7a3L+B0AtRP5ETGYeEwhCzeGUIdeopl/f4ZL3E8iufy91eNrh8+dEOYt3?=
 =?iso-8859-1?Q?I1Wu2DBa8fblNyKa9twlgmg1sDRCEiZ7W1w+I3NAxY9o0vPBl2hZZn7jqY?=
 =?iso-8859-1?Q?k1joQ2f6/v3ylVfAYz6FFMGCc4I/ifR1qp09j9WfPiATrGIbAQAXIhGuut?=
 =?iso-8859-1?Q?+S5RFyEWBsyM2x0nQKVjGxVRYVCkaNcaQKbJb5CdTxvVquz6Z4okZE84BP?=
 =?iso-8859-1?Q?BPisL/CfiqTZ0w2M4q/frTKx9dDob3oKiiksMWNDFbZiucSZDsQ7y3b7kB?=
 =?iso-8859-1?Q?rNFBQPW0YoUh+wfINrlO0oBeUxoBJbtYiXgeR2T07e8OdYdFsK1tkaHJM3?=
 =?iso-8859-1?Q?BGDubTBTv8N5ZJ6TsdOt9xMtgLtLWVsYFHudNAz681WCrIEcGqP6n2HTng?=
 =?iso-8859-1?Q?sd2Lkkae61p1POeY6kPqWlDu6fe3dYouYkaHRzms8hZzEcqLZE0AL+fDHX?=
 =?iso-8859-1?Q?h4UFQDt0ACaAcyQ3RJtX1iNEu1/tDQQGgdd/pwU9IUlcM2l9c/AUlNUfrh?=
 =?iso-8859-1?Q?Q0TGvzGJuXvZWkwHZAwK5TZTzndt03D71k4caAslywKcowJ0t1Wz0jA3cz?=
 =?iso-8859-1?Q?YeKxzflbbgUw1emnWALc/Fu6pahugstrZJ25dMFebgWylAxBGGp51lghL5?=
 =?iso-8859-1?Q?o0+mN0xtZ4ckSGHMTKicSAdSKLaEXxCT3fh8NwsP8ZzjC4RRIhdK9TKVs+?=
 =?iso-8859-1?Q?2X+Lm35sK0Z0t0mKJv1G6+IZGvgk8RxIDOIihVr/jPbrDpOOvYtUVb9OGo?=
 =?iso-8859-1?Q?VKwah1QWjiJQCeNeNbGbNTtQlJPvq4K0vZ0J/PXAwVkkrmCrZGO9FFpWwI?=
 =?iso-8859-1?Q?kq/S4KKkkeaOsDXkacRi6iIyx3kL+jjZQA6w+d1+SLXreJK2iLN589PAl7?=
 =?iso-8859-1?Q?c7COYs/Vj/3RoJDb/6zJeqWXRROC877EX4Fn1mscSNSrG6et1y5Uz8OFqz?=
 =?iso-8859-1?Q?ZmRpYzXy4NVrUscabaJwPyYFsojNS43k+jwdJh4hnZAzzD8vW+v8cM/CpF?=
 =?iso-8859-1?Q?r7/LFEysa10r530VP5Y7dypZnnQMd1q7tJYUyKbABlMVwhwqhE+SEm5put?=
 =?iso-8859-1?Q?wKOLznoa8Kwy3Hc1zt7dRUWZaEZsb3sJLfL4I0w0Vr/QDFdeJYP+3LOjeK?=
 =?iso-8859-1?Q?X3AYCK5R6QqR9QMuOD/tirVLNqftCXzcmjj9/Y4n9u+fJAYyUabtL7+vyN?=
 =?iso-8859-1?Q?XQ7DAzR94PFmWEomgtX2HQm/sDmKP2n8lyy6A7z7DWvsYjfI/XmJjClTxH?=
 =?iso-8859-1?Q?Tx7rOxKHTJJH8yYSjV8MsWbRLrne55OT79Yt6rGP122R31CUjXg0?=
X-Exchange-RoutingPolicyChecked: KblZm4sgifSSCjZ/BX56k8/swZ0S1CD7Fhu6XQ6WANqA4/OrK7zdq14SiJHUo8+ua7uMQyr0fZfj+gfQ4kUZwF04lNjteOfyLAI1i5Xhwcl7KICGKY3gflRS4Yvyh++j208Npz2BIxtCganjCBTfDOCLoF0dhMsa7EraEoM+y2+nrXC0yyzZ0OJNCQYNiOG7zq7cCuaW7q4RPckxAb39uLJBcjOY39BxR4HUmf5s7YoV3PgKWo7r6JECr1BE25YmE6CQob9piZZ2SjvRcn+sGJlq98Miv17D1YvRsuTnF8TlS4qE8Ogi71vUyRuv7OYheFuKKnpvZNDJ414gou6NmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 056ecbd2-b434-45fc-fb76-08df2d55ff90
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 20:25:49.4412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haMToRwwhQ4WHtWtdn/76fFP7Nuc98aLye33NqVNuH9jk1uQoVF30yNWtv2pH2li6i8ZzkTXKTVWPoI0+Jkcn//5EgIlAbVlamMEpEQVKdiZuiK5zHy9aqbHPjuyzW8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
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

On Fri, Oct 16, 2026 at 09:46:02AM +0200, Thomas Zimmermann wrote:
>Hi
>
>Am 16.10.26 um 08:26 schrieb Niranjana Vishwanathapura:
>>On Thu, Oct 15, 2026 at 09:27:08AM +0200, Thomas Zimmermann wrote:
>>>Hi
>>>
>>>Am 14.10.26 um 21:02 schrieb Niranjana Vishwanathapura:
>>>>From: Farah Kassabri <farah.kassabri@intel.com>
>>>>
>>>>Add drm_gem_prime_self_import() to detect and handle the case where a
>>>>PRIME dma-buf being imported was exported by the same DRM device.
>>>>
>>>>When the dma-buf originates from the importing device and uses the
>>>>expected dma-buf ops, the helper returns the associated GEM object and
>>>>takes an extra reference on it. This allows drivers to bypass the
>>>>generic PRIME import path and avoid taking an additional reference on
>>>>the dma-buf file.
>>>>
>>>>The helper simplifies self-import handling and avoids duplication of
>>>>this pattern across DRM drivers.
>>>>
>>>>v2: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
>>>>    helper routine
>>>
>>>Why even bother submitting this? It is the same series that I 
>>>already declined with a few cosmetic changes.
>>>
>>>The abstract entry point for importing is 
>>>drm_driver.gem_prime_import. The implementation is driver 
>>>specific. No need to over abstract. Keeping drm_gem_object_get() 
>>>separate from the test is a feature, not a bug BTW.
>>>
>>>If you want to improve the status quo, change dma-buf such that 
>>>prime works without relying on the vtable and ->priv. I outlined 
>>>this in my earlier replies.
>>>
>>
>>Hi Thomas,
>>
>>As mentioned in other thread, your earlier suggesion of
>>'__drm_gem_is_exported_dma_buf(dev, ops, dma_buf)' is not fully helpful
>>as it would require drivers to still take object reference. Besides,
>>this also depends on 'ops'.
>
>This is a feature. These are two distinct operations. Taking the 
>object ref is another of those implementation detail where drivers 
>might want to do something else.
>
>>
>>To me the 'dma_buf_ops as export identifer' seems to be well accepted
>>idiom, though we may say it shouldn't be in stricter sense.
>>

Ok

>>But if we were not to relay on vtable and ->priv, then it looks like
>>the best alternative will be to have DRM subsystem maintain a list of
>>exported dma-buf objects per drm device. Then during import, parse this
>>list to determine if the import is self-import or not.
>>
>>I am not sure if it is worth to add this list just for this simple helper
>>routine. If using dma_buf ops is no go, then yah, let us drop this 
>>series,
>>keep current code and may be look into this alternative later 
>>through an RFC.
>
>As I mention before, the abstraction is drm_driver.gem_prime_import. 
>Anything behind that is driver-specific. A real improvement should 
>provide a driver-generic implementation of gem_prime_import. This 
>needs changes to dma_buf and to the prime helpers. OTOH 
>gem_prime_import is already fairly abstract. There are no low-hanging 
>fruits here IMHO.
>

Ok, will drop this and keep any abstration within the xe driver if
required.

Thanks,
Niranjana 

>Best regards
>Thomas
>
>
>>
>>Thanks,
>>Niranjana
>>
>>>Best regards
>>>Thomas
>>>
>>>
>>>
>>>>
>>>>Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
>>>>Signed-off-by: Niranjana Vishwanathapura 
>>>><niranjana.vishwanathapura@intel.com>
>>>>Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>>---
>>>> drivers/gpu/drm/drm_prime.c | 10 ++-------
>>>> include/drm/drm_gem.h       | 42 +++++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 44 insertions(+), 8 deletions(-)
>>>>
>>>>diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>>index 9b44c78cd77f..7a15c29052eb 100644
>>>>--- a/drivers/gpu/drm/drm_prime.c
>>>>+++ b/drivers/gpu/drm/drm_prime.c
>>>>@@ -974,15 +974,9 @@ struct drm_gem_object 
>>>>*drm_gem_prime_import_dev(struct drm_device *dev,
>>>>     struct drm_gem_object *obj;
>>>>     int ret;
>>>>-    if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>>>>-        /*
>>>>-         * Importing dmabuf exported from our own gem increases
>>>>-         * refcount on gem itself instead of f_count of dmabuf.
>>>>-         */
>>>>-        obj = dma_buf->priv;
>>>>-        drm_gem_object_get(obj);
>>>>+    obj = drm_gem_prime_self_import(dev, dma_buf, 
>>>>&drm_gem_prime_dmabuf_ops);
>>>>+    if (obj)
>>>>         return obj;
>>>>-    }
>>>>     if (!dev->driver->gem_prime_import_sg_table)
>>>>         return ERR_PTR(-EINVAL);
>>>>diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>>>index 885244e375d3..238ec08f0d81 100644
>>>>--- a/include/drm/drm_gem.h
>>>>+++ b/include/drm/drm_gem.h
>>>>@@ -646,6 +646,48 @@ static inline bool 
>>>>drm_gem_is_imported(const struct drm_gem_object *obj)
>>>>     return !!obj->import_attach;
>>>> }
>>>>+/**
>>>>+ * drm_gem_prime_self_import - Attempt to import a dma-buf 
>>>>exported by this DRM device
>>>>+ * @dev: DRM device performing the import
>>>>+ * @dma_buf: dma-buf to import
>>>>+ * @expected_ops: dma-buf ops used by this driver
>>>>+ *
>>>>+ * If @dma_buf was exported by this DRM device using 
>>>>@expected_ops, return the
>>>>+ * corresponding GEM object and take an extra reference on it. 
>>>>In this case,
>>>>+ * the import avoids taking a reference on the dma-buf file and 
>>>>instead bumps
>>>>+ * the GEM object's refcount directly.
>>>>+ *
>>>>+ * Comparing @dma_buf->ops against @expected_ops is plumbing: 
>>>>dma-buf has no
>>>>+ * first-class exporter identifier, so the ops pointer is used 
>>>>as a stand-in to
>>>>+ * recognise a buffer this driver exported. A dedicated 
>>>>exporter identity would
>>>>+ * let this be done without reaching into @dma_buf->ops.
>>>>+ *
>>>>+ * Returns:
>>>>+ * A referenced GEM object on success, or %NULL if the dma-buf 
>>>>was not exported
>>>>+ * by this device or does not match @expected_ops.
>>>>+ */
>>>>+static inline struct drm_gem_object *
>>>>+drm_gem_prime_self_import(struct drm_device *dev, struct 
>>>>dma_buf *dma_buf,
>>>>+              const struct dma_buf_ops *expected_ops)
>>>>+{
>>>>+    struct drm_gem_object *obj;
>>>>+
>>>>+    if (dma_buf->ops != expected_ops)
>>>>+        return NULL;
>>>>+
>>>>+    obj = dma_buf->priv;
>>>>+    if (obj->dev != dev)
>>>>+        return NULL;
>>>>+
>>>>+    /*
>>>>+     * Importing dmabuf exported from the driver's own gem increases
>>>>+     * refcount on gem itself instead of f_count of dmabuf.
>>>>+     */
>>>>+    drm_gem_object_get(obj);
>>>>+
>>>>+    return obj;
>>>>+}
>>>>+
>>>> #ifdef CONFIG_LOCKDEP
>>>> #define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
>>>>     lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
>>>
>>>-- 
>>>-- 
>>>Thomas Zimmermann
>>>Graphics Driver Developer
>>>SUSE Software Solutions Germany GmbH
>>>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>>
>>>
>
>-- 
>--
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>
>
