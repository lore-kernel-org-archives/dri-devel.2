Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D61FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9DD10E01F;
	Fri, 24 Apr 2026 23:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XamaqXHR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9942D10E01F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777073388; x=1808609388;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K8+XTBgUXMLE31q08xSzyEsuWrZaVN9IlJyWRjmN24A=;
 b=XamaqXHRLXlkm4bYyXxVfrQOmMHumZNxTIounatFFYP57eAPzqKZVFdG
 eLO5/QjkmbrDbJiX8dDiUqweObuIKAaFOWq3yplthozijQAjdiT/J1jKM
 rnVeeEoWQgH72L7q5i5yCC9K2id7kAptKMIXwruS351dT72RPoMMrp6zn
 AR5F6yQYeVlgE0eBnYAyVMC9P2VJE2BhInWrvAdXpnTDlTjlYLJpCINBw
 Mk/uO5MTrF0J+rPUstPsnJZdD2zStnyG+FuoyGZOaqxcB2KP9BBT+F8LF
 i+2c7wNL2erHUnvrtxvz/n4XP4roQWW7jKOWF3pVISwBWowEIpDpn4+5e Q==;
X-CSE-ConnectionGUID: h7b/QiWgSFO3Kv3/h78d0g==
X-CSE-MsgGUID: geA9Jl+pQrK205WgJnDT+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="95473091"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="95473091"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 16:29:47 -0700
X-CSE-ConnectionGUID: lYXvj35kRu6XjVRsM3SYAQ==
X-CSE-MsgGUID: /ZDlSBKIQy6wF8b7k2wOkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="232920163"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 16:29:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 16:29:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 16:29:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 16:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6xtZsZqauwmYYLFM4RugDppEs0zjnDZv6Mj1DWvzQCCa7dx+9yUYajjQ6dxsLi2OUykFrSg5mgGtd6Y6dWai9aLr9pGbeqqgcG082T1/1W5futdpF8zVOCECP3rITSFS1g87hrzbVaSpvohkLZ/WcSulQ+05e10zYR0S9ipShzE842V8ol6gUEDiHuU+l1JeqRIH3tCcb6K2bgNSha15KBBB2bxSdWuoRCDIHS+48tswOZbEBCBqA/jbpSCeZK3M0XWJylN+riJaLv53xDJTIcd/0k/Tu0IMkg+xqwZeD6C931umFv1BnVbp4vI/GTtp26oQPLxAATMjANO/Tw09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQrJew8d+Gp3M3hvz+qmbAa7ZHNh/DWemSUWu6JMIxk=;
 b=RHarFMdQRh3so6fIXOdIl/ujn7mbamos7yv56t3Ftw7sFkY7eJKgvKMxPT/IP1tDtb7OJSaoQQ/bm4UosEkt3VatoGMXuS1u8hiP7Fsh5S99CBh0VhC340gF8niFfVKKGNpqpNDW7MxXqQAo2tOa8hu3EDxCJDraiRwPVkEiTVgpe8aOxwr01NSU21ekDjjAuBXk9p43F3RMVZEH2fOlQAQnFzA9AubQbxmIlFajjbw4nVr5MnCFIkKtpltV/zlJTPQQmhxhtQymF4OYABAx0JjW3qJyjY5Ix9igdgr2Zq0bGPl7XAe3ORdVylc2cCyc1aBrYIMKKkVjadNf0ZRZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 23:29:38 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:29:38 +0000
Message-ID: <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
Date: Fri, 24 Apr 2026 16:29:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Thomas Zimmermann <tzimmermann@suse.de>, Jocelyn Falempe
 <jfalempe@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: f67a88d5-1b0b-424d-5a64-08dea2595a65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: y548uTYWusU7Zo8Rw14lnF4w4XHufS7QNZTdBin4GHtsR0mzLbTpGxMVZdGEmjRcpAh3seBmIhacXcueG9F1KVlrUpmbJQNH3WB7K+Yxpc1oHQpyriXIZ8imz/RYJmCl2lG94qGJ/hvKGy53XuQ5mSOnBl+bNr128X+zSJb+fr7MoMLhuVJMLVbZegC5Cw2m1Ao4JMFJN4ppMNd/KWrbMFNxGt5ZXPf3zdSuxFoxSbUVK9qecanVCAxF2toHczq8B1tp3ThBFHfGnbascZ4+xBjMURSwprajKuiGi5jiTiNlT8Tjq0jYfKkRP7rRW6L6pnooW9CyS4WFWCHcuScEXJCfvKbAE8EakhasV3T7WpqUrNnodZVeUR2G1lsh+1BthQMhQTBKj5vCq5BVNja/GJDVpwGZqdxpUUQYUx2CdWJVxrv7eMT/WYJLFxg5Wx6hZIzpzCWtnhzkMwxavahiR1L79oTWi1Ir6medOW5ImTM5cSSYt3ZTY7IXpkz107uePdwJGsDdgT1/8C4CNmGyRfSfDaV0sf2liN9vwSrwgoktn8DfPa1uUyAAzYsoLXmFnGG8i4TFnlUgIhW5QSDbpkRkCgqWMK07v+i88yR57NDJmnQnoPHai4sJhSZAA/KUWwihWy8STJ+xKk8axkySscC/Srg54b19t8Z/Lf4ywg50cEjp2xGpOjvprpKzNaKtimVqlSHD/0dN3aKHxs7UnO8NoQvU9WR5wSwpY9uEvS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7588.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVRR2VoS3lMWExBZHo3TW1lU2o0ZDlid2taRk8rZ2NOZnlzSm85Y2Mzc2Nw?=
 =?utf-8?B?RDhMMWNZTTRJRndxRDE0SFBsNE5pSTNoQVgreTVuMXVmeVo2enZHRXNXRGRD?=
 =?utf-8?B?bGxpR3NMdzlib1FaQ1BwRlk5UU9EeDNvWFFMeDhMTzVxbGFGYTJjODh2amtx?=
 =?utf-8?B?bFppdld0c3IrZUYrUDVvNUVIbUhjTHhkWHh2eDVDcjBvRXNUbjlBblJscDdt?=
 =?utf-8?B?UndQWURjM0dFZkwxSTgreXo1QjBzOTVZci9neXVLRGZ3eVc2bnNkOHNIYjNL?=
 =?utf-8?B?Rm5vT1lST2luTVI3Y254VWhsUUJ6R3daS1o2ZksrRGVlVzZqbllxcHVZV0hq?=
 =?utf-8?B?NDNWZ0YyK1ArdnE0V1BFY1ZnckIyS0NtQloxUld5aU0weEk5ck90WEk3MTc3?=
 =?utf-8?B?UHdlS2c1MWkwcTV6cWhPZHlka0x2YnRyY0RjNi9oUkxJNm0vNkp1SXhVd3ZT?=
 =?utf-8?B?OGtacWIveXZIT2ZvVDlpVjZRMGRFTWVhMWhSTVczN3dQRmdQOGRCV25GVCt2?=
 =?utf-8?B?TkJqUWFTc2lNbzJacVU4djlZdHlnSjEveTFaVHBJQVI5WXVnZVdWZjBDd0o2?=
 =?utf-8?B?aGZGenRLZVFXNkVicjBMaDgyTzRNSk5pQm1tZ2tVaTdmd20wQ1BUbzRoWnVt?=
 =?utf-8?B?SEs0cE1BbnFYRFRMQUVBKzBnZk5HRHhpaWVwZ3N0TERKanZ1WWw3dTV3d04w?=
 =?utf-8?B?UGU4UUsxaWhIYjhpTHcybXRYSGhVMCs0eC83T3RBV3NmV00xMitBdXBzVEMw?=
 =?utf-8?B?TEJ1aENQbjk2UGdzcG90RWhrUjFBa0pLaUlsd0FlS3V2OE44MFFITTRYTnB4?=
 =?utf-8?B?ZXVSd1pjc2U5M3VxMzFuSGIzTGllYlNWSHVsd0VTZTArdzBDVGQ2ZEhrd29v?=
 =?utf-8?B?R0Q1RWErS2ozb3NOUWF3WXdEbmN5UGJKbWlkaFpJZS94Y1YxbnU1dG9iZDJn?=
 =?utf-8?B?ZmtvNHM2ejZ2NHd0WVZmQXdrTmtEMFd5VGEybTUxdTUrMi9GZi8rbTRuejlX?=
 =?utf-8?B?VlluNWxZQ3ZkNHE0aWlKdzhIcnJzNEFUMzl4VDVqQVRlZzQraCsyTGw2OWFB?=
 =?utf-8?B?RjBEZE9RRjNCSng1azJNTFpqRW1vaVg1Nzhsc1B0eVNBbExUNnpoeWtHa21U?=
 =?utf-8?B?S09YNFh6Rnp4d0xBT0NsL2hQMXlGbURSa2I3WU1lbnQ4aEdOTWRQRC9XZk5k?=
 =?utf-8?B?RnFxb1g0Q1B1Uk53Ym5PcXdjalpxT0JNUVpCY2VLMDdlamVCTURjbXBtVE5G?=
 =?utf-8?B?QmpNL3ZmeFdwelZjN1pHVUVVZ01ubEpyVmdPeGozZXVpRVFWdEJreWJVOEd3?=
 =?utf-8?B?dWc5YmZudW5hdEVvWDd1SFhEd09TS1RmbnRBUk5pbnZaSGRKZUdnQkM4VDFX?=
 =?utf-8?B?TEdZUXFHSTd6eDVubGhNOGt5VmdIYURtZXV1SW5TQldybFpKKzFieVl5a2cw?=
 =?utf-8?B?VEkvZFdNQ2ZzME1WdGRROVBUVk9iSDFZaWRLUllvZ2NtV2hrSFNGeDBuMnZ6?=
 =?utf-8?B?bkJPd09mdlZsQjk3eGpsLzExZWViRXhlc2ZZYmpnbXhVRXJuL0RrQzFpNDl4?=
 =?utf-8?B?NmxrUHRQb1JSU2JMOWhhL1RtOHdad0ZWeTZmeDF0bnNBOGVYL2dES3haM3FE?=
 =?utf-8?B?b2lBRE9IditjQ0NvWFBZNG1zaFFWb0dCZWM3SFk5SkQxTE5tTlhNeDh5V0dV?=
 =?utf-8?B?cnMrbDQ1VG94dThSODZycnk5bjRrc05jSjZQcDZuVStReHZ2WjFaYzJDQ0c0?=
 =?utf-8?B?NnREbDRXTzBWdEhGc2hjWEVMZkd1QXhsL0srUVBxdW45ZUdXc05oc3lxelJB?=
 =?utf-8?B?SlFjU1ROdlk2dFVST3RXOFR6aittS29SbXArckxOWGJJamxBUk9LNVJLTlpy?=
 =?utf-8?B?aUF1U1VNQlBtMkFQVk1RbENtblhueGxUekdkd1VsVlp5RjNyM1h5VVpMRWVu?=
 =?utf-8?B?bzBLcFF1RnNVQWJkYXZWZFpwN0NES281dnJIV3RlQ3ZZR3lZR1hXZTVkZzFu?=
 =?utf-8?B?TDBEeVU3Vlp3VUVodWxlcTRvSXJZZDZPeFJQdlNyVjZQV3pHczlNNytRSFlV?=
 =?utf-8?B?cVlTZXIrZkVncVBHVm5FZGVjOUo3Qk4wYjIrUzl1QWhVQTFCRDlyVU8rcmRC?=
 =?utf-8?B?WnpGL3ZyeW9pS2RXL3cwa1RwQkNtcWM1cXlGdTVlYkkyNm9tL2d0M2FwWHRP?=
 =?utf-8?B?QkRQbkkybE1XS2xSdGF1V0dRMDNnd3NRRnF2U21pNHRrNTBvdGJNTytvR0la?=
 =?utf-8?B?MDBsZ1RlamtlelRaa2VzL0xadmxJNHdvdmZlV0l5cEtoZjlyRk1WOTBhVEpR?=
 =?utf-8?B?K3hWLzlGdlIzM2t1WlVrZk41OWdPNzJXaTBEK21XMnByTWZCNFNJUT09?=
X-Exchange-RoutingPolicyChecked: Bs50+UIM76tOqQFeKPjYe5vDEAZECMcN1hDFfPC/nBAcsapBjh3Kh+40bASMOvvcFjBflhDaL9D3bEFb32+exPc2MUJhdQHquPOwYAd83XSkIN11iXkQoamdCOL/00HUPtL0khXqVJVokiS4GQ/0rhR8Aaa9RwS4OjJw6uXy8D4AC6AmhHC5E8TXE62UB/hWblgQ4I8y2FCYoJzFm7LgLYecOYddf/LcsS+VPGQKvokkJ+JfgS8xc8w3YN+eCTJnxsw+vjWcEiB8q9Qxo48IQ8RW/FjlxPn0xItHu4ghzfqWuOVvsR4Kq2LUdj47vkOSXoF0OXnFM/5/g5hxPOaL8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f67a88d5-1b0b-424d-5a64-08dea2595a65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:29:38.7429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hRWm3zZ2MaKoWy0gL6K1GAvVtpDf3Tggw9jk3/JLJAYqFmLc2d4JxF/qdYizDLz/aCrhot1+k24yEPA2K+ZqvU4X2hAHJb9AUyEu+Whh/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
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

On 4/24/2026 12:47 AM, Thomas Zimmermann wrote:
> Hi Jocelyn
> 
> Am 24.04.26 um 09:36 schrieb Jocelyn Falempe:
>> On 24/04/2026 08:20, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 23.04.26 um 21:42 schrieb Jacob Keller:
>>> [...]
>>>> Unfortunately, I also have no better idea than a DMI quirk table to
>>>> record known platforms that include the controller but don't have a
>>>> physical VGA connection exposed.
>>>
>>> I'm in favor of this. If you send a meaningful DMI identifier for
>>> your system, I'd make you a patch for testing.
>>
>> I didn't find something related to VGA connector in dmidecode.
>> My suggestion would be to use the chassis-type [1], and disable
>> polling on Blade (0x1C and 0x1D) and Rack Mount (0x17) as they are
>> less likely to have a real VGA monitor connected.
>> My Dell T310, which is kind of a Tower, has a chassis-type of 0x11
>> "Main server chassis" so it might not be very reliable.
> 
> This is the first time, I hear about this problem. I don't think it's
> very common. And it appears only to be related due to cheap hardware
> manufacturing.
> 
> So I suggest to pick Manufacturer, Product, Version as key. I'd be
> surprised if we find more than a hand full of systems with the issue. If
> we see a trend or common pattern, we can generalize later on.
> 

I think this is the best solution. Keep it focused for now. I believe
Intel has two major platforms that we care about with respect to this
issue. I'll see if I can dig up the data. The systems install the MGA
G200 for BMC use but don't seem to expose the VGA connection.

For the specific system I have that was faulty, we have the following:

$ for t in system-manufacturer system-product-name system-version ; \
    do dmidecode -s ${t}; \
done
Dell Inc.
PowerEdge XR8720t
Not Specified



I believe there was also some concern about HP systems which similarly
use this chipset, but I don't have the DMI data for that one off hand.
I've asked some colleagues to confirm the situation and obtain that
data. I'll get back early next week if we think there are any other
systems possibly affected.

In the mean time, I'm happy to have our team test any patch to confirm
that it behaves as expected and resolves the service interruptions.

Appreciate all the feedback on this thread.

Thanks,
Jake
