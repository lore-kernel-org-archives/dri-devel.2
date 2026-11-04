Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E864606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iOzrap7o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F25910E882;
	Wed,  4 Nov 2026 09:07:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BC910E857;
 Wed,  4 Nov 2026 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793783273; x=1825319273;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZaheQvtyOjUXECxfZnujAnI8oLzQnhlGTMdBJYgk3Xc=;
 b=iOzrap7o5+FgT8XCXX5lXrxtwqXXsTa6DV2W8WDhqMvjWoobY8B1t+V2
 RbxVea66RkJHC/D3aYtTFiwrzHBpeeW0Kq89rkqBejho3kQhk+QeDbOn7
 REYfTj9RuKnaeE8Pi3TUJuHE3Qa1zGymxHylzW/eypf1XqToGppZEefUm
 UGOcBsPTxgD539tK7xw3cWMP1IGyQ/cEk/IWmCiLHfMCoZ8OdZGQ5FE7y
 vRKmv/x9StP85ssASnbLDVANFMSE24+M+deO+e0Jl+Xia+4THZ3yRg7AC
 Fe4mlXUeglgvgfUgiFAimH987lgp8YjgMaq0C3zhkJ6FKHBljjNvyjE/m g==;
X-CSE-ConnectionGUID: nTvQY0hSTRK9FRxxW0bkTA==
X-CSE-MsgGUID: E/WpDwpdQEaJxCLXasNcQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2427886"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2427886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:07:52 -0800
X-CSE-ConnectionGUID: oGt4G9wQS6OYJTM+kMtEgg==
X-CSE-MsgGUID: 0X8oovlHR6CzHSHU9b8BdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7028997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:07:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:07:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 01:07:50 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 01:07:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFZAfHHTVgBt5IfLeQ6vyOZCKylwC4Ybk+s4577Ki42kPwQ8+sSUg2I7hUl6KVLA1pd6UfLLM9zcClQrV6ZXfovodr195p3T4gVY5Mwyxgtq2ivNj0QoTpi/H6PJaNKCMjAaW8idRX0QHmLgL8/cnQGETVxf6+8wraxLmqWDlDeuzr225RX1yYUcJnmhI3+O86mAxFgHVgW+EUgKrd6x/c1hanjN130r/Op8hfDX63iREOKMRay4fiFBnCLF4HwbzoedKi3DENaYpKbLkghl2IOZmZ/K1SGAfQT++T/YxlZoQd59JhCP0jB0Yi6M6Afpk6uvH3VGaZwjABkxJjV7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ+UABxU4rJjX+FSeBD3UluqkZTCXuqn8G7yB4KLmG4=;
 b=GITY2EHFg39jlfrYX7RzwjSl6haY5hwoi2Vs7TGXwCSnAFPtOyM0fR9nlUspqDriA10n1Xie7TxTJLTP5tEOTCVSFSSKZ5kDJW/hL9S4wvw4OdWl6NR1yJ7FOznfxHhSd5eUJp6UYMirpQh3rxWAjH7Cgv5HZRTrA04wderku6L4fHcXLW9KYvotfUQh3tJXjGN/5kr9egKHr2LnZMLnzwzB4/YUTCszTwPmvNSH6QKSZAv8sXjbczyuazan/u/a/AD8TVqEuF+lzALbj1RI4Ib/1Zw8yS1DM8VxsEq2GntEhcKX2tq7T3koYMlVq/cNkXmqnJgw7Lv0ptHxuMICIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by PH8PR11MB7117.namprd11.prod.outlook.com
 (2603:10b6:510:217::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:07:48 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:07:45 +0000
Date: Wed, 4 Nov 2026 09:07:35 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [RFC 2/5] drm/i915/selftests: Port GT-dependent selftests to
 work with multi-GT (low-hanging fruits part 2)
Message-ID: <nyphozcrkaqrz244iehvgo26uh5ssdfk3maysrl4yvegk2lnun@22xxoq5mpajn>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
 <20261029014155.55865-3-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261029014155.55865-3-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DB9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::6) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|PH8PR11MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d796e2-34ae-46da-83d0-08df3a531747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|260925021911599003|260925022911599003|260925021311599003|261102123227099003|18002099003|10067099003|261009223027099003|261021135927099003|261022105027099003|261022075727099003|56012099006|261022113327099003|261021123027099003|261021130227099003|261021133027099003|261022115727099003|261021121427099003|11063799006|4143699003|261028144727099003|261026121527099003|261026140227099003|261026135527099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: s6UCuUZLnjtrRJEe/E9Zad96m6zhOvLr4cI8wzfY7e15sM0iuytTBn0muX6M4P/oSQ4Z09XP4iWPlOZ7uxBza1QjGnRqnfOk+UBeidlI8TVwcdtj+umUV4ayhn17Nr85gfwcirtVvO1bDNQtAcLlfV0xEa1zETfoe+yvkqQYhQUWIlEgdgU8Vr9UZJlMrZapQun2MW5/zlq2wCXQ6UYYB3gdJbL1mTPTg9D9i4GO8U4+IGelCQB9jzdLm+wtA/H0TlpBLuyT5Iis7PR1k4jMd1yq8ypsbwYbCS/X0AXzSzky9wDhGnu4ry/TTO3SzXY3wDFqwzjkCmpOkXGlWjGGTMcMBl7Ye0g2+tJLWbiwEaVKzNqqdMmXcRP/skVIpsGktbJuj+BvjPIwoSvKLR9JPTbHtQPvIPFc92wUrO7gBeSjwkeGBJMwFtA/Mj+KiKkGn2DLQTAX4d7zJijQkCR747RWu4s6zJpTBM1bC0dnJvi7/7HzbcjP9TESjEj7p6U8pGYMsu7ilAwjOWhCV9qzBsHaLHKJu+KSNL1mYWhfdvX0T6ESBJych+ryoj+yttNtrJS/aiddlwbmDyixQlAZOtr3hUALq3IalbIBJu6mGDMim6ROmHZ6GILqKzx76KOlCYKAdlXi0oCegplWPGGLv3wCwzRWaSj7TrOaLtTyPXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(260925021911599003)(260925022911599003)(260925021311599003)(261102123227099003)(18002099003)(10067099003)(261009223027099003)(261021135927099003)(261022105027099003)(261022075727099003)(56012099006)(261022113327099003)(261021123027099003)(261021130227099003)(261021133027099003)(261022115727099003)(261021121427099003)(11063799006)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003)(261026135527099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFvU2lxd1NBWFhKNUhYS21wYUVycWEwa0JDci9PbldQZ0dWQnVnSERGUjBH?=
 =?utf-8?B?VVB3c2c0YWxSMzNyZ0h6d0ZtUDhGWldiMGVWd3VaV0NBakhTa01qQUl6K0dV?=
 =?utf-8?B?cTJYazF6YVFGcTcvbHI3OVVNYllYZkk1OEFpZ1p6cVkxWU5hZEhTUDhJTGVB?=
 =?utf-8?B?ZmxONHFsL21zdTZucHdoMWR6SHUrUVBNN0VIa2pWbktsTi9UNzU0OEx2OUlk?=
 =?utf-8?B?elA5RVVWUTRQYWhKa0crb0ZNQUs4SzIyeHhxU053R0pYaXlrRktwWTVxQWRS?=
 =?utf-8?B?N3ZCUEJQTEdrNi9PV0FlaUUxenh2Q3lnMVkyV1QrcGZYazM2OXlSd2pybTFL?=
 =?utf-8?B?Q1pXeUl6T2srQTRleEZBWVFxM1JtU0RON1dUUE80OE9Bc01sS2wzQlJhdXUz?=
 =?utf-8?B?MmJNOGVYejc1RHlMeFM5aDN2bHdPS0ZkYmVBRytrMCtoUmxYVDdBZjJnYzM4?=
 =?utf-8?B?L3dNc2NtclpDajArRnZORGJMR2ZGSFUwTFBOemloZWc0SCtyejg0K0VKSWQw?=
 =?utf-8?B?ak5HbkJiN3piRmQ1TGRjQXNXQ3NKdEVLcVluWTRCb3NlU29IN2Z0NVN4ZkZr?=
 =?utf-8?B?RUZ5OUVDUWtxUmhIOXJmS1NhdTlyWXNqaGxPdnViT0VjWHJlaG5SMG1NZ3NK?=
 =?utf-8?B?ak8zS0srVDlpK2ZoVDBBekQrYk54a0JiSHAzSDNML0d2NnBVeTEzS1FnOCtG?=
 =?utf-8?B?VjNtclF4UktFeURnU29wYWE2WjNtZE42TlVtV1krU0doN0dPVU56N3Q0V0VS?=
 =?utf-8?B?dFFoU3pxM2JYK0tMN1o3dDlKdWFLYTNCWFFwRERHSHRvaGhaSGZSc3hUQlJp?=
 =?utf-8?B?Q0htNTRjWUJ2TElCSkpQT3FCamd1TXVNUlpBWkhvWUszOFRKZmhYdUV2djA0?=
 =?utf-8?B?ZXhkbnpRdkM2aDA2akQ2ZzRWQk5kcUEyNDZXRG9QTUxkb1JqQlRIRm1SL0dH?=
 =?utf-8?B?c040Y2hmdlJGdjQwc3JSdW82QUdHbk8za1JvbDdiWDlzdHdtV1ZGME9zT05C?=
 =?utf-8?B?NXREZ3ZCQUYzRUp0eGltMzZSOTBmNzZXcm1vajFZWjVtbUZwRngzaTh6Qk9q?=
 =?utf-8?B?eFppUVJsUGZPMkJwZnNqVVp1d1ZlTE9UaHZWeVVzeGVMcENDeGlKTmpiWDNi?=
 =?utf-8?B?cXRYMnlJSU43SFVkT1ZBcDhPeGE0aU9nNGlKZEE5R3hrM3dvVkZ0ejFpNVIw?=
 =?utf-8?B?dGlIaUR3UHNsSkpZWVdLM2lmcitvM1lpUVA1V1BDTFpSNSt5djAxK3d3V3Uy?=
 =?utf-8?B?UHlEcEgycXBCUGNRNWJjcFBjVE1lL3Zpb2xrTEIzUDlpQ2pDV3ppaXhKYW8z?=
 =?utf-8?B?M2xjT3loOW1vaEF2UGRWN29yeDl6Mllid2tGdTB5MzhFU0RsZmhEcU9UUS9q?=
 =?utf-8?B?WlNuUUFRM1c1c2F5VnU2TmY2Q0U3TzlGdHd0UnlaVHZLM2NvOThFQUdFeTNL?=
 =?utf-8?B?ZkhvcEdLQXFCZW93T3ErUmJMMnF3M254MDVpdHRMVG1iQTkwV2hic1BnV2JN?=
 =?utf-8?B?WmFxYVpQdHFsUUtFcTMvV1dhTVI4SHJNaXhmV1hMVjNWbFFwdDBOa3RGRTYy?=
 =?utf-8?B?SytKVk5lT0hZa01WZEdOM2FKek5EU2RkdVFPWlRLUURyYVQ2cUs2LzUzdUJv?=
 =?utf-8?B?bTl5cllyWCthRVNZWGYzS29ReWQxM2pKWksyYnAxc1N3d2JkU2xGUVRmT0R6?=
 =?utf-8?B?Q1ptNUNDY24vMTcxaUxsSDAwUVhhcmI2YjdGZ1RnUSt4RmduWVg2c2hFYnV0?=
 =?utf-8?B?K2hqL3lDbkVTeFVONks0UzdodmE4NjkvNXYzckZzWWVRTTRRZ3dlT1RYSzVK?=
 =?utf-8?B?ekw5UnJUV0xwSGJLaDdNZ21yK2xiL1kvNlBmV3BuR2YxcVIwL3FvL3JyM20r?=
 =?utf-8?B?T1dOaXJPOW1sTUQybklMS1ZqdGNQRnlaaXJYejA1TGMzRFJHdDUwdGNIaVlr?=
 =?utf-8?B?eDRuVkpJWHF3NlhGWWRyUmZOK1I4UXJhTE83Y0hBcFZNcEc2SFJmMnA2OW5z?=
 =?utf-8?B?dyt6elFtcHdqQW96Tnp3ZmZoNmFOdnB3Wno1THRxa0tTSi9vOTFDUE1Wc05t?=
 =?utf-8?B?OFpMdFE3ZW1lN3hwUHU4aDlQVGFqbHpObTRqSzZmUFdzbHhQOTZHUGp3dWRp?=
 =?utf-8?B?SzVXb0hPY0JYNWNZTGhQdmlKMUV0bnBITUNHVEF6d0JHWGRCWHBzTkVDKzUz?=
 =?utf-8?B?VFhMV2J2WG5mRkRWSlBUeFU3QmZ1RitId0NhWUVMZ2JBd2VsK1JOTUV3Wm5j?=
 =?utf-8?B?YU9vUEtqN0pqaGw1dVM0bVZKdTQ3WlZyd2c2VmVGeExqS0Jvb3UySksyeE1J?=
 =?utf-8?B?ZERyMEVVUnN2WVI4MWFMNXdKSUFJU1dUTG5JRE9iM0FCcjVBM1R5RkxYTmJ3?=
 =?utf-8?Q?KQ+ShE3n1kPihVJA=3D?=
X-Exchange-RoutingPolicyChecked: NmNrClKyH5PIKYGvYOGx1P8pBvz1Y94rx25cMfk4RPZNYs+QcfF4E/ByM0BqYhx7VHdWES3EGXvl9IqVeg4Y4QgDe00tGOQN85wMfTFxbnqxgEHf6L0Svbx2ZPYFygck3Oc1+pPOM50W84uolWyGuxJWaZE0N0jAlGq6Bx6e0qCPjCBvo7D9UPCAgto/7Y25wdCkp09kwHSFEGLRuJWekmKrMLMIB88Kq/eDTDd4/hyKeehjpeSjgtdmdU6PcOODVzG7I7ov0FiRmuEQo16Ff52ggBJ/spojIvYI5ifoxYjt3inKJvXLUMJtrF1YEX7NxN/MnIOeid8C2J2I3zQ06g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d796e2-34ae-46da-83d0-08df3a531747
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:07:45.7836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI98HAokcyAay4sDZtQRCq4bIPVkH+Idj86NQI5ApWAnI7g8ntCIhSBpUCtHl8OD9IB4bP97C34CwZ8WX9/IZja/VJvQgA+9FaOKlI+Orjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-10-29 at 02:41:52 +0100, Krzysztof Niemiec wrote:
> Some tests aren't passed a GT directly and don't reference them, but run
> only under the condition of the GT not being wedged. Update the top-level
> selftest functions of these tests to abort when some GT is wedged.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
> 
> I made an assumption here, that if ANY of the GTs are wedged, the test
This potentially increases failure rate. I think it might be
safer to identify which tests guarded today actually need more
than one working GT. Otherwise you blindly add more CPU cycles.

> should abort. It is of course possible to make it so that only if ALL
> GTs are wedged, the test should abort. Former is probably safer but if
> there's good arguments for the latter I can change it.
> 
>  drivers/gpu/drm/i915/gem/selftests/huge_pages.c  |  8 ++++++--
>  drivers/gpu/drm/i915/selftests/i915_active.c     |  8 ++++++--
>  drivers/gpu/drm/i915/selftests/i915_perf.c       |  8 ++++++--
>  drivers/gpu/drm/i915/selftests/i915_request.c    |  8 ++++++--
>  .../gpu/drm/i915/selftests/intel_memory_region.c | 16 ++++++++++++----
>  5 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> index 44718e728291..a8ae65ddb073 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> @@ -2012,14 +2012,18 @@ int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(igt_ppgtt_huge_fill),
>  		SUBTEST(igt_ppgtt_64K),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
>  
>  	if (!HAS_PPGTT(i915)) {
>  		pr_info("PPGTT not supported, skipping live-selftests\n");
>  		return 0;
>  	}
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	return i915_live_subtests(tests, i915);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
> index 9fea2fabeac4..4e1d3ccdf8c6 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_active.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_active.c
> @@ -256,9 +256,13 @@ int i915_active_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_active_retire),
>  		SUBTEST(live_active_barrier),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	return i915_subtests(tests, i915);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
> index e9469e27f42a..e64d3b430994 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_perf.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
> @@ -425,13 +425,17 @@ int i915_perf_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_noa_gpr),
>  	};
>  	struct i915_perf *perf = &i915->perf;
> +	struct intel_gt *gt;
> +	unsigned int id;
>  	int err;
>  
>  	if (!perf->metrics_kobj || !perf->ops.enable_metric_set)
>  		return 0;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	err = alloc_empty_config(&i915->perf);
>  	if (err)
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
> index e1a7c454a0a9..6bf8ba474497 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -3295,9 +3295,13 @@ int i915_request_perf_selftests(struct drm_i915_private *i915)
>  		SUBTEST(perf_series_engines),
>  		SUBTEST(perf_parallel_engines),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	return i915_subtests(tests, i915);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
> index 8307390943a2..20f85db9e3f3 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
> @@ -1380,14 +1380,18 @@ int intel_memory_region_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(igt_lmem_write_cpu),
>  		SUBTEST(igt_lmem_write_gpu),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
>  
>  	if (!HAS_LMEM(i915)) {
>  		pr_info("device lacks LMEM support, skipping\n");
>  		return 0;
>  	}
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	return i915_live_subtests(tests, i915);
>  }
> @@ -1397,9 +1401,13 @@ int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
>  	static const struct i915_subtest tests[] = {
>  		SUBTEST(perf_memcpy),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			return 0;
> +	}
>  
>  	return i915_live_subtests(tests, i915);
>  }
> -- 
> 2.55.0
> 

-- 
Best Regards,
Krzysztof
