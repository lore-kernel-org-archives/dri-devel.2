Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C598107BCD5
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BC110E0A5;
	Fri, 13 Mar 2026 17:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DPPyz7q7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FDF10E0A5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773422874; x=1804958874;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qDeqCCTI7pXxMKVmiwEXunQ1VBD55LOw3ETChKUIoD4=;
 b=DPPyz7q7REUXq3yg13taOoyMC/ls7phQQSr1j+u41S+9w5pdg5OafzIW
 7oescCUc3CoVzgrH9zeLBZLsTO+u6mN2QkHSqZuRFby0IyvSBNz+WrKPs
 Zo2k2zDBM1sQUL5Z/DE3JMaHdyHSlCdLyaV0VoF06N3PqySvhfHIO+god
 F5ASua4lPyyssBoWVlH2sTfpcg3HCNuOfUS4U9++w7ewSB87JYP+/YkbC
 ksriFEYmiV6F/Jk5C1h0I2XAbjkTTUAQfSQSEe85ohycPSdQPAmYynSkS
 8D46MD0DOuey0vGml9CysZfhwUGTd/e+20EktFG2HBJhhseoly6cP6H3K Q==;
X-CSE-ConnectionGUID: 7pEPrkNLT/m+YDF9N5dyng==
X-CSE-MsgGUID: dRiRlPo1QLe9wUKwmOqDJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74414651"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74414651"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 10:27:53 -0700
X-CSE-ConnectionGUID: p/cwCpkLQVytuWuRimDWGg==
X-CSE-MsgGUID: +g6BlFWWT1yDoMG/b2JzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="226215874"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 10:27:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 10:27:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 10:27:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 10:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpAi4CFm3C1hBs/1dTdQY16gu6uTFFWovlw/w5QS3Uh3qzOhAj5bVU1OFhUxnWlQSQntQMnXGdsIQpeqLxkj+2ulYLJWJnFog/4FsqVSXevqXXX2mCIQ3+eRgWomYCPXAHPCD/yAMdPIRWxLIesOGXYyAwuByOJs2IJ4P6+A0lQHCgs0lNoR9meCqU0tteSbcCtRySKialR0rHBpAcW3G2oAn8X0b2IPPe2Y/PzdtXzsCJvZJhgZYB+sZEM+l+GhzK+3nAoEGET1LcwFvN0EAxJNQ65Tu2FNeqwXmdvG9ex0smZuzWV1o0TYoK6blVLkM4X5pzdMkSSNEPaoHrJabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1TP1HKUXE4lJjxPo+lIoXaZIC0l9O0EczJM286NBJw=;
 b=WYtme6eRS5Cju6zbxovGDMxR2wvz7/a1wBhIm6WuyeqW8+rolp8CJsGXr3+bspQSrlg5PA9U++SgtzlVymDD01AbsnXTr8mSdI5XNNQK4twLM/b8F31TJewAaQMQPagjE6eg33m0O/PXcYxBMU5CND9Chh2OcXes+sYRQra07/UpbGPq4dQh8V5iKamCjrjvJuPFKWJc7A5A0nnEDodjAYy23FDJ0RtR1k2fk7gwQ97PC4DuIoLvntwN1OgigtcWCB6SN5/+OqCdNV0JJKLpO1j3bwdnUIz/rw/nsqGkS3EfuUQDjeQSxJ4/I3ib59pdyFDc6Jndz7E3TyrZx31dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 17:27:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 17:27:47 +0000
Date: Fri, 13 Mar 2026 10:27:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Philipp
 Stanner" <phasta@mailbox.org>, <phasta@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Gary Guo
 <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <lucas.demarchi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
Subject: Re: [RFC PATCH 2/4] rust: sync: Add dma_fence abstractions
Message-ID: <abRJEG8dodzboWHp@lstrano-desk.jf.intel.com>
References: <aYsFKOVrsMQeAHoi@google.com>
 <DGB7RWKMPJQZ.2PHB127O6MVVN@kernel.org>
 <4e84306c-5cec-4048-a7eb-a364788baa89@amd.com>
 <aYsZHhX2IVO2kOSm@google.com>
 <DGC1KP1DT6YV.3LQWZXMA22L5A@kernel.org>
 <20260211112049.089b2656@fedora>
 <DGC2WYUT80B4.3D4QKYP8FVVQJ@kernel.org>
 <20260211121223.78674f22@fedora>
 <DGC7JWOL70HH.2AMUEI3M10I9J@kernel.org>
 <20260211160059.6e0d3b60@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260211160059.6e0d3b60@fedora>
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: eac7d2ad-c6bb-4d86-99ad-08de8125d80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QxJCPBiB7mt1vGyj7vHZigKl1hS61+eQ3aImtG4Co3jOHpJzkMUwLTh73f3vo0dZCbdfLmbtT45xD3mxi+TReye4laGDH6QcRrDrz6/0+/lIyCXCZX9tfehKq8MmVQbXd9TAikHzEiA22dWUWyuUBzeQrYzhmxZEw+97HZ6NVt0kTRHZkn3z6N3LaJRi/+b7ImJd/ptXLBEf30TAqkN9LjVBPn/krXmhloGs608QA7aClNC1U/W6Q+xmD3yR/IW4GGLL9WG6OGDzNkv+XF1Xy7d3wAp3COFz4Xuuzc/BYEIYzFTsCJarY3LE/IN2xh+oSEwLd9FRzu49FLTswvrqsIvV2yo7o1bOs5bYTAOdSbr+Mji9kz0FC9kOG5z0zIbKkYBiQTKskuxdOtgid4G7EfGRVJVjazcSNNUxN/+rP78LZixH3pBho89kZM+GXrrADI7Wt325z6vO1Is0DHVqge1AzIfPXHavrK3b589Ow+YLJ2dcBoSe++W+5xyYMAGue56NwvsDomy2A2veMMhTg21yItEHwCNrrs9xFrQKUBL/5kdtGZXTXly8yrEidNrTrbnHp5lursLuIyyS+czjYvtb/BN0VGb3MwODUpMoP7r+pSeRqvXl+PSUaUYzO04J2T3WUGf+NEChBWR7isQzLEhToTwW4jLlcbTW7q+e4j9xTDbvgNN94AA2unTLTyg8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNHYS9NT0xjdVRyeUc0aFBxZ24vS2REc3pXQyt5N21SNUVmTHE0SDI4Ukp4?=
 =?utf-8?B?dEhIZ0N1RVBoRHA3L1E1YitUU3c2Q0tCSmhlZlBpWGs5RFlWR0EycWExNTFB?=
 =?utf-8?B?SGZGamU0VnJsWnlLTUl4cjZIdGh4V2wwUEV5MGhEN1dwRTI0MzBLNitUdDNu?=
 =?utf-8?B?c2VnSkF2dUZOMnltWmRWSS9iTFlyTkRBTHpCbkY0anZzR09KdzIvWHpRRjRs?=
 =?utf-8?B?WWRXV01uRnJZdWVvWlFBZVVDajR6R2FZUDcwUDE3SHNkNzIvMVM5RWU5aXky?=
 =?utf-8?B?bXRSdlJwRmJFY3lRRzhtWnZNbDVvZVpaK2g1QVovOFhzVW5pc0lvazVzeXJW?=
 =?utf-8?B?bTE4SnVtbWd1RkhmcHZsRGxLRHBqd2s4WTBKVklRV0IwdlQxdGVYTFBicGhp?=
 =?utf-8?B?M0UxQkZKcVhsdXh5WUNURFZXek4wWkFDWUtiSXNjdXpUZEc0VFhCSCtoV0VU?=
 =?utf-8?B?OWlyc0VSM3ZHWFo1Y0tBT0xwcVdlNXBESllKN0pEdlpFZTJPNXkrWGNPeVdt?=
 =?utf-8?B?SWg3eVVONkNQYWFmdFExUE5Ndm56Vkp2WGIwcnlINUxUQ29HL210UVZaaWRQ?=
 =?utf-8?B?MmpHeXNqejZFQ1J6T0NWcGRMQkl4ajJDbnJ3QVpZdGFpMU9ydTR1YTl5K2Zi?=
 =?utf-8?B?WmsyTzZTMjNKeDFxWTZWdDB6V01uUmx2YnFid1A3ZDJWVWRYL0JVWEgwYUVh?=
 =?utf-8?B?dmxmemxoU3MzOHZUd21YS2c3bElQUENiVEpDeUdZVE1KcWdMcmFKU0dtUVdm?=
 =?utf-8?B?aCsrWS9zTU1PaHNweXNDQ25kSmhWOUFFTFZBU29ieWw5UE41V2kxKzd1bEdn?=
 =?utf-8?B?RUlOdk5GaHZrblc2c1luZVV4bmhPUURjYTl4Qy9GNEZkQnliQmFQeTh2enR3?=
 =?utf-8?B?UEo0OFJEc1FBaUVoRW9JMk8xZUxDamsxNklCSjZPcXFodytvM2xaeUpBbElS?=
 =?utf-8?B?S3dUVGFBRmhhZk1xUHlUa3d5MWhuU3J0U0NINjJ6aVB3ajhCUGNRU00vSEJk?=
 =?utf-8?B?alV5TEhkdlhUOEpmZ2t5REdiSDVrQ1J5Z1ZYNXlVSkpHeE9NSEFSa0xxQ2Rj?=
 =?utf-8?B?QVF1STdrcUtGSlBxbzNUQ2dKUzJQRytCblNKZ2Fad2JYN2hKc0NtRm5XaHI1?=
 =?utf-8?B?N29pcUVlUWNDSU1oRnYzMGs4OEx5U1VoN0ZvSVRxS3I0aUhnNFFTeDdncS9N?=
 =?utf-8?B?d1gzL2djZTN2bk40dk5DTksvL1M2VHZEbmtEdUZ6WVdSeTQ5RUVVOTVSWnpm?=
 =?utf-8?B?TEpzeHdpUm5aM0Jvbmd5b2dvY2Z4SWFURzBxYjVjblptQkc3cW9nMWpoYXBQ?=
 =?utf-8?B?TUhHSW5YQm1kalQyWDJ3eHBsTW1ZTVE3NktaUXIybnhpQ0dNWGRGR01mc1VB?=
 =?utf-8?B?ZzVFTlk2QS9JWmFSMmg5YWJDYmNScFRZZlNYVFEzeC9ibUNuTWxCS0RiRXNC?=
 =?utf-8?B?OWxsS2dDU09TZVJocEJFaEtjZ0tmWUxNVEUzb0dLYmx3enozUUdJMUdSSzhY?=
 =?utf-8?B?WDA3RnJFK0M2eE9UWkZwYU1rWEFVVm9OYTRYT3JJd0VLQ0tna2RnWW1oQ1cy?=
 =?utf-8?B?RVhoekxBMWRGZlQyK0tBeGhsR2NKNDQ0UEJFTUJqZC9DaytzY1dickhGNldU?=
 =?utf-8?B?SmhmUWRPRmMxWkNVRVNlTWVRRmQxTHJMSElLOU5velpFSnVJQjYyNkt3OEpX?=
 =?utf-8?B?TG9OVi9ocExzWTgwYjJBWER5eHd5dHpuTG9MM3BRK29TTkI0VXh2b2xjWkFW?=
 =?utf-8?B?RzQ1YUdkUEowOTBQMlJxcjdiRFhPVVU2MUhPMVFzUFRnUGdMRHllK3BOWmZo?=
 =?utf-8?B?c3Q1ektJSWd5V25CQTlrT3ZXVmkyZWpSUVNZRmZXS05wdFRpRHhVcyticm9J?=
 =?utf-8?B?d0p5RDNndERxTUZzbzRNbFgreHY5RDVUMVU4aE5MaCtxd1BzSDdzUHdpZnFM?=
 =?utf-8?B?TDZnNkVPQmVyWGN0MUVsRVV3emVZTmpCY3hJaWt1VkRoTm5CVTNrTENOaEFh?=
 =?utf-8?B?SGF1d1lHTUs2UGJmRnZ3ZlVUWWZjald3bXlhK3lVUzB5alpoY3ZOSUx5OHMz?=
 =?utf-8?B?S0psSDRKMEY3TEtKUGoyVHFadW5SaHZWaEF6bzMydm56bjVHSU9USXVYd2ZQ?=
 =?utf-8?B?eHdZRDJRbytrWTJpditiSUVXZEJUaGxDWmlSYldabUVUa2FJVEI3TEVDcits?=
 =?utf-8?B?RUZKNDFXWTVkdW91d25HRjFRc0dGOFFiNXlLWFk1UWlydDJpeFl2ajdVUGJV?=
 =?utf-8?B?c1B3bW9mbm5VeW5jMkhmZzBSRk95Wm5JV3YvWUdzUTE0TXVTRnVpY1Mza2dW?=
 =?utf-8?B?bmkyTXNVS3lFSnBKc0w1TURBb1pmdGVJeExYenFqWTgvdWc0cnpTUT09?=
X-Exchange-RoutingPolicyChecked: hN+dBWU4KvfvAb0IsaTLHstj+xbf1UyMTHnbwsBwUILAV9jk97xDqKvQpQd7HwaUKBEKgnxx2CBYVJtaSBSCoA2GRgzyVCN33mNfRzA7Y+Ff+NE+CDmu7fVsOPi1QjR91QwOjygHPjBfLYjA5D7Ixb9lBIHXKp68Tz7r9xWI0LxIHd/ay2KwvWiqW23d/fL7dI/yB0FbkBLrGVm/1frLNQBYqZ9LYdipgLhjjWWuKSrtTr2p+mhwxS4BB+ofBgDsVDsOPReQ8wVVBOLsDEkWfRYYHOc7Azd29hHp9idf9SxsbtRB/l1OwCrYCukx4gEi3NVhQI/aNhnESvk0o9mBLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eac7d2ad-c6bb-4d86-99ad-08de8125d80d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:27:47.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS76Yv8LpknSmSMZAG0d2S4xHIHgA1QFKFpGzoGeM97+uatlPS+1wgvKZxSl9ico1qFPz2oQ1Hndmb4O3RJXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
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

On Wed, Feb 11, 2026 at 04:00:59PM +0100, Boris Brezillon wrote:

Jumping in here as I was tagged in this thread… a lot gets through.

Randomly picking a point to reply.

> On Wed, 11 Feb 2026 15:38:32 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
> 
> > On Wed Feb 11, 2026 at 12:12 PM CET, Boris Brezillon wrote:
> > > On Wed, 11 Feb 2026 12:00:30 +0100
> > > "Danilo Krummrich" <dakr@kernel.org> wrote:  
> > >> I.e. sharing a workqueue between JobQs is fine, but we have to ensure they can't
> > >> be used for anything else.  
> > >
> > > Totally agree with that, and that's where I was going with this special
> > > DmaFenceWorkqueue wrapper/abstract, that would only accept
> > > scheduling MaySignalDmaFencesWorkItem objects.  
> > 
> > Not sure if it has to be that complicated (for a first shot). At least for the
> > JobQ it would probably be enough to have a helper to create a new, let's say,
> > struct JobQueueWorker that encapsulates a (reference counted) workqueue, but
> > does not give access to it outside of jobq.rs.
> 
> Except we need to schedule some work items that are in the
> DMA-signaling path but not directly controlled by the jobq.rs
> implementation (see [1] for the post-execution work we schedule in
> panthor).
> 
> The two options I can think of are:
> 
> 1. Add a an unsafe interface to schedule work items on the wq attached
>    to JobQ. Safety requirements in that case being compliance with the
>    DMA-fence signalling rules.

For (1), use lockdep to enforce these rules. I have a patch for this
[1]. Something like this is probably what everyone needs—jobqueue can
either create a workqueue with this annotation or enforce that the one
being passed in already has it. I turned this on for all Xe workqueues
in the signaling path and immediately found a few bugs, and I know the
dma-fence rules pretty well, so this is clearly useful.

I think user-scheduling work on the submit work item is valid. The
primary case in Xe is control-plane messages (e.g., queue
suspend/resume, teardown, toggling queue priority in firmware, etc.).
You don’t want to race with submission while manipulating queue state,
so you order this work on the workqueue. Could you do this with a lock?
Probably. But then you’d have to audit every point that issues a
control-plane message to make sure you can take that lock.

There’s also the hazard where a control message is issued in IRQ context
but you need a mutex to manipulate the queue (In Xe this the mutex to
send firmware commands). For example, I’ve implemented fence deadlines
in Xe [2], which fire control-plane messages in IRQ context. Another
example is a job dropping a ref to the queue in IRQ context, and that
being the final reference that triggers teardown. I don’t do the later
yet in Xe, but it should be possible to drop your last queue ref when a
dma-fence signals (i.e., no free_job work — just a put in the dma-fence
signaling IRQ handler) if jobqueue is designed correctly.

I’m also not sure timeouts are supposed to work in jobqueue, but if you
need to stop/start the jobqueue to ensure you have full control over
your queue (e.g., new jobqueues aren’t racing), then you likely need a
second workqueue so you can stop the submit one, or you might be able to
get away with a mutex. This also applies to users scheduling workqueue
operations on this—such as global resets or migrating a VF—which stop
all jobqueue instances to perform fixups. These global events can’t race
with jobs timing out either, since multiple entities can’t be
stop/starting jobqueue instances at the same time without breaking
things.

This is why, in Xe, all job timeouts and all global events are scheduled
on a single workqueue instance shared among all DRM sched instances.
This has worked quite well, so I’d strongly recommend carrying this part
of DRM sched forward into whatever succeeds it.

I have a fairly detailed write-up of the Xe scheduler design [3] — it’s
a little stale, but it should describe how a subset of DRM sched works
very well to implement complex driver-side scheduling requirements. A
whole other subset of DRM sched is horrid, so I’d recommend taking the
good ideas from DRM sched (queue stop/start, workqueue-based ordering,
finished fences, job tracking to completion) and using those in
jobqueue, while dropping the bad ones (no real object-lifetime rules, no
ownership rules, no refcounting, wild teardown flows, wild dma-fence
callback manipulation, etc.) and not carrying those forward. Some of DRM
sched’s very bad ideas appear to be in jobqueue as well. I’d reconsider
those, but I won’t harp on the design at this point.

Matt

[1] https://patchwork.freedesktop.org/patch/682491/?series=156283&rev=1
[2] https://patchwork.freedesktop.org/patch/696820/?series=159479&rev=2
[3] https://patchwork.freedesktop.org/patch/669007/?series=153000&rev=3

> 2. The thing I was describing before, where we add the concept of
>    DmaFenceWorkqueue that can only take MaySignalDmaFencesWorkItem. We
>    can then have a DmaFenceWorkqueue that's global, and pass it to the
>    JobQueue so it can use it for its own work item.
> 
> We could start with option 1, sure, but since we're going to need to
> schedule post-execution work items that have to be considered part of
> the DMA-signalling path, I'd rather have these concepts clearly defined
> from the start.
> 
> Mind if I give this DmaFenceWorkqueue/MaySignalDmaFencesWorkItem a try
> to see what it looks like a get the discussion going from there
> (hopefully it's just a thin wrapper around a regular
> Workqueue/WorkItem, with an extra dma_fence_signalling annotation in
> the WorkItem::run() path), or are you completely against the idea?
> 
> [1]https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/panthor/panthor_sched.c#L1913
