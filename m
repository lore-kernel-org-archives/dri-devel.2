Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0534606A337
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I6Sp7coz;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Igl8twdd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2DB10E009;
	Sat, 21 Nov 2026 06:30:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177CC10E009;
 Sat, 21 Nov 2026 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795242634; x=1826778634;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Urv+C0BjEq9CoR9xGsDx4YSghjWwWvUcb9nd2JEIeC8=;
 b=I6Sp7cozDfG5ahSW/7JKGTAeZdQYmO31tNijaLxmzFcewz/WvWEPmD08
 fdCXPius+O++n7viKfTM3sqL5d03vpyK8C4Ljjyh1N8EDSbMmOItUS5VJ
 UI26yOfUBGzjc3rqnFDXav23LQN8ayEH8gPGy2TcI0iPZRR3ZaQk07lAA
 uA8bzN0GOcgRmMjD56Ydo++rUksg9yCx6yZvWC/IKxoecFmKt0liE7/GS
 Ldbytwii3twP9bZT6OtBImqii0kaz7HP8JvbFZdmlPSqOEYMgO6RPwBLj
 x/66UsJ/yOXPIEvxd38w5O4uPFmVATPm7z9GjJggpUe5SMalTFD3v6wjw A==;
X-CSE-ConnectionGUID: 33/bI4k+S86AnJFbZaGwww==
X-CSE-MsgGUID: MfLZ7ueNQAKiHJikbJLiYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4113859"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4113859"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 22:30:33 -0800
X-CSE-ConnectionGUID: Wd791hfbTFK3WJ0Dwk5YfA==
X-CSE-MsgGUID: eF0xu/mHS0G2dll/jYfj+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="12692441"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 22:30:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 22:30:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 22:30:32 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 22:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKjyHHHmAukW0BNN0XUjZGSw2GFcVv39RhLbx4SdoWr9sAAIBvlggCaOY3Kscn616TwxIgm7TYDQukjcj26WhbbErp6V527unzpRL623ZTDQn/SzjpV440UxXkgu1YH95GskEl17uUcqOS4Y35hyqp73kgifstlG0+i4GAByQbhWKwVx8mZxHSDGCeQohiz3r04z7wRP0+fS1/i2/+4K1pBEdMxSk1Vt2g/+HrE5GuEVgRia8yVXq3F9y64gYEl/Vz07hdG+q5OXX9GbelEdhCw+9p/3PcqDVf/Rbxb5zq+U2uV+RCRB74X2/+QSfZWczl1Oke+Btm30baJCeE7KoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEN+tavdRczevqF0UK0uYjEo4fxbwulH0I5CspeqRv8=;
 b=rAYNhdBXheuE6Chc6wjlu/dqGBLmnF3LafPpBDxXgPw9LmsXqgOu+odDnQQ9BEEZlR0xFJ7VrsS2NMXVsBSTPaFLVtdQSjw/VFDLZI9zHs+qchOsEDMe7Ov0TE/B9/6OUxoqofQ4GLItV+n4BzvZrvwb1D+d8aTdmA0cpQd/qfXwDY/27ampEirVZzZqQ0cm0Hfug1PcpUU5Ou2qNyFiFc/SNbPzhVumDe7ohtpjavAyPTC7023cSQKH4bsHctHMS7w+nSL5JKGJEkZwbcgHY7K4SX/fAkkdISq3HpTB1v20q8xWa+o0uSlDGV9coRvGypYAZCsdZprQ7IkStlWT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEN+tavdRczevqF0UK0uYjEo4fxbwulH0I5CspeqRv8=;
 b=Igl8twdd6ih3JhXV2yaHvmlJtP7xab0pzVXzHPVJsvS7vmylhBpDZ3hq5vh8RyrUpkgACD/g2P2X++w7REWuloZhFuOfG86u+9/7Vr/iDlMTyrsU45kFX3x5nCh41BvpJKjH3O5994HMDTfxKBjYZ/IvTxV9fHX4exhC4haxHOk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DSVPR11MB9889.namprd11.prod.outlook.com (2603:10b6:8:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 06:30:17 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 06:30:16 +0000
Date: Fri, 20 Nov 2026 22:30:14 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 05/33] drm/ttm: Support defragmentation moves
Message-ID: <awE6dk5EYBiu8k1-@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-6-matthew.brost@intel.com>
 <au1Ax4zGApeRJF47@nvishwa1-desk>
 <av9Yz12dG7+vtgb2@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av9Yz12dG7+vtgb2@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DSVPR11MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e639d8-c8cb-42c0-f853-08df4798e80c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261021123027099003|261021121427099003|261021130227099003|261022115727099003|261026140227099003|261022075727099003|261026130827099003|261022113327099003|261022105027099003|261026121527099003|261028144727099003|261021133027099003|261021135927099003|261026135527099003|56012099006|10067099003|261102123227099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 7T5QWPt8NZdSxBg0zQT2RT/Z8jHZF5vv7f9MdFXewRO4Pqk2iuOeKxETjakskWFBUlyK/L8w7NDuUC2iv5f1YwRF9Nnk6VPWFzd7g3FFcuLycrcVJIuCkMns78+OKV5IhoP0786hJeZl/wh/rZ4Vhy6EC97EpDFDWFAHJ3z+dGTLbC2S4UycY1IYBluHrWR6HboE5egG4Ows1z55D5aTEj0Nsw74s5Zcr6+Fq38w/PvcfY1yW/7OkBx4DXjrBMqqj3b3Np6s4rjlImpYK7r/ZvydrA2uWmKKy/973CwKdg1KThn4eQ3tbQ+UrWDpu7jKtRpGWdSMzGltNDtB10A+5s+96nPdVwTMqwj0IIeLOS3IFogt5CPBFDPJjyTPvTw7O5R8HMZ2Z8p9qjDbV/FKB4lb7BmIMQCXiO8hjYYw7F+DBOWsjRO0PiA2GT/BcVsGqdXZTPgZ4wU49qHbepV0hmOjHyTREda530OpNFIsb1RP09J9zeNrcYjiNFOk/4VCXMeKWFIcf4q7XocZBAHnZzooUYiq/Lm/d/AGN0h2cxmHDe6x2s4AZ19rQzPwLPHdmLUsJQlVTzBWTQu5mVZ/gt76T1NaMqQhwUjVW6G+n7etLR9n1ZeGm1oCyxsy4cloKhIo8WXHrdeFVBAjQBhOyyrGH4zmCmk5qc5NWz7bScA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021123027099003)(261021121427099003)(261021130227099003)(261022115727099003)(261026140227099003)(261022075727099003)(261026130827099003)(261022113327099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021133027099003)(261021135927099003)(261026135527099003)(56012099006)(10067099003)(261102123227099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVHN09ETjYzWFVzUjBaOHF0eWQ3QlBNcE1OVmRXOWhCMzFuRlVVcVMzOVpK?=
 =?utf-8?B?RW5CeERjZmQwZzNydkJScnJZOXhiOXkwUFlwdzZBVDhZd3lLNXZtWldFV0ZI?=
 =?utf-8?B?QjY5L1ZUNEkvODZFaDNJYmo1ZDcrT2w3NGFKWFpJeWk2SnZNQmxtbFZvaGow?=
 =?utf-8?B?RFJDcVB2NjdJZWFkQ2V4SkZTaWZyeEJnTm83UVNSNkJLajh3Zms3V29BRzdv?=
 =?utf-8?B?N3hOMVhyZE1lUDNObnF0NWtOcXArM0IxYXBiaFp3MzVUd2RmMTdSMTRtRnRa?=
 =?utf-8?B?dEQxR2hUWkpaNXYrRmRRWW9ab3E0dlkwYUk5OUZCc3BucUF3alpCSmc5ci9i?=
 =?utf-8?B?ZlBySUFhcEZGQVZEQlQ4bjNuU2s4cnh1OXNuUWI1VlkyZ2tuUkFnckZLZ3FY?=
 =?utf-8?B?eG9Kb205NzdGSmIvUDZ3anRyVm0wTWtaa3FMeTJoYW5CMFVxTFlYcFdtR2Yy?=
 =?utf-8?B?cWNMTXFNcU1VaG40OW5OV2ZTckRDYXRLVlR0UUdRVzZLNFdpZ1VUdlptbGFi?=
 =?utf-8?B?bVloa2I2N0dTa0pVeXhqS1B2R1Q5cDBhWjUxRjBDVzdaVVpFZjJocm9PSGlw?=
 =?utf-8?B?M2NXZUVQbnVYNldZUGM4NExBRG1MRys0TUxFbC9TMGFUb1dhZ1FSVWNVUUZI?=
 =?utf-8?B?SUZEcGRXbURUZm1oa0xMNzEwRUpUTHlyOElaMUVSUDUrQ2F2M3Bsek5YM2c4?=
 =?utf-8?B?NGhvTXVnNFFwWUhlSERUZmRMV1dOWFhaR25sMFFsakVEKzVjQlVucVRnQnE4?=
 =?utf-8?B?c1Y5RUVyZEEwSXF6d0VjajFHenRTSDkyakx0cmRoYmswUnllWjYxOXdrbnBj?=
 =?utf-8?B?bDB2b2xhRThwN21OaVZtRlJQVGJxNTRRWnliQ3NpU2hneHhGclBFeVZoa2gy?=
 =?utf-8?B?dEhkSEpteXBLQ0luSXpWV1cwOTVpLzNKcnlQQi94VkFyMHdGbXIwQlkwSGxo?=
 =?utf-8?B?SEVYdVhmSUczWU04dnVjTWxNcTJUTDhpTWRpeFJ2Wi9nRndJNFdzeVBCeG1N?=
 =?utf-8?B?VXg4Sko0ekFySTBxSkpkTDc1bXlZOXV0ZWttV3MxQ05MWUd4WGJBYnNISWEr?=
 =?utf-8?B?NGpvazN3aXI1R28reDZScm0wTXRKVTZSajVKYXRtSmdHdS9iY2JZZUVyamNY?=
 =?utf-8?B?L2FKdlhWY0dhS3k3SHNaTDBEZTdhazV5N2JQL2t6QnhBcktpajdUd2F2aGN4?=
 =?utf-8?B?TEtpZFJEbjB4TDRwWWpEdk4vaTNuWUpWL1YvaDg4TVkyTDNvbEdqSEVRZ3g1?=
 =?utf-8?B?NzFaNHF0R0xwS0o3MWlXbElBblVTNGo4TWdFczZCYmJTNFhtKytJRSsvVkU1?=
 =?utf-8?B?cjdKdkE2ODdYWE51b3pwREZnSy9IUmhkQ3p6emU2bktTTEtvWGhuM0JXcEhZ?=
 =?utf-8?B?MVFWUGtrTVIvY3FMaG8vOHZCb012SDdtS29sRlc5aTJObmp1OUtUNjJlTWVK?=
 =?utf-8?B?VVpUUWlqeis2UUlneUsrWkFlRUJSeDZPOWxsUUJBd2JmNThjZzFzSkhhYmxo?=
 =?utf-8?B?alJjOTBrU3pZTXZLc05wbytRRFpnMHZSOFpFSWVTQ1E3Z1l4R0RDNStFRk1B?=
 =?utf-8?B?ajRibTZtd1doM0QxWXJ5OG9HOVh2c1RLSVpMN1Zzck5hdzBZOWF4M0ZsRlN6?=
 =?utf-8?B?V3E4THRHNXp3Nys2aEFCTGRqUVAwMXc3Qm11bStIK1ZaVTZCOVFpVFFMWUV4?=
 =?utf-8?B?QlZWREtSK2ZQemt1Vm42TDh2bEZjclA1UHFWbkI1R0Y0cExTbzZwb0JGY0VU?=
 =?utf-8?B?NzlPTEJIMHYycGNBdGM2V2grVys2NjdrOFdydXlCR2lsOGdCMjZPcmRYU3NX?=
 =?utf-8?B?SGlqWjdxai9tcklXY2owS01UQkpRQmJ2YXpVK2UvTmZjbDNna3dpaE42R0lh?=
 =?utf-8?B?NkpmM296dE5Yb01JMWYwNWxIU1hHa0pMU2Z6VGN6OVdiRlE3WlZRVlorMTQ5?=
 =?utf-8?B?L2lYK0FBeld4N0FZNkFLWC80RFMwVkFqUzhQMERaK0IzckZaQkoyeEpsWVcy?=
 =?utf-8?B?MURobndoZVVmYndrMlRkN0hoeEVWYmd4MkNmWk5LZUxmTS94dXNCbnlpekIx?=
 =?utf-8?B?UVMzVXJLUG5zbHl4OFRuQ2JDbFYrbmRtNGJkQWxLb2N3aGFnbzhaNmduNHYy?=
 =?utf-8?B?Y0xyanhnREtlN0VvZGNsaXhITjJaSzdpNkZJbUU0cVRNK3p0a0dvcVJnaDRo?=
 =?utf-8?B?dndiVmJaZHMyb0x5YU5yUzBJYjFNeDlrTldqR3JlZDRwL2lvY2EwREZpV1NF?=
 =?utf-8?B?ZDFlR0VRQ1Mvb2FrRnhSUndobHJSRUJVTFFBdzRWNWNJeC9Ja1Nqa0gxWFhZ?=
 =?utf-8?B?WmhxcU9ST2lDMlBUMVFhdzJON1pZUm9PQVJKQW1oU3NIWGNUY0lLTTdpclZL?=
 =?utf-8?Q?BgtYNy2vzjjbm66finI930TMzjvbO67SFVyfr?=
X-Exchange-RoutingPolicyChecked: myoYLXMqYBOxs2BZFKfZjoCDWDNCb8pXHmTZWa2HgGyFT2csPGnI6HgumLtmlF9zn4wdh/brl77QpNugai0HLsb3W8A3e+RvOTdyfYwquWnsgBj5Wk3NKdOyOeRmujpnDdr2lLn+zIuQsIpGr2m5ntuDjyOQr+7vkWPsYvZ2tz+Dp0CQzuC2TiDvErLiDY42Up+BFqywekwMaExwvgz2o/xwLAkAvrWsBqAKViHvsh6wa/kTaeftUJeDDUhAFSYIrPY/Id/vNMBbyZbyOkgiJSeh6oIcDX+Mf15646QMmK2MViiWxa/vG70rK9LtNC1ZlL08FtKRtG2Bk+6xKNx0aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e639d8-c8cb-42c0-f853-08df4798e80c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 06:30:16.5492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt86HwJgEGX0Qly3BDvwUqiUpXy+P6Gs5JSeIgigncKumMOYODgBf+g078JeoMGm1FQAqrxMHaF8iVEjEmqGcfYBE4NtXzMmkT1d9Qtmjc4bXFtX01FxRxXfbhlJayw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9889
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 12:15:11PM -0800, Matthew Brost wrote:
>On Thu, Nov 05, 2026 at 06:51:51PM -0800, Niranjana Vishwanathapura wrote:
>> On Fri, Jul 10, 2026 at 07:55:51PM -0700, Matthew Brost wrote:
>> > Add infrastructure to let a driver re-back an already-resident BO with
>> > fresh pages (e.g. at a more beneficial order) by reusing the normal move
>> > machinery.
>> >
>> > Add ctx->defrag, which makes ttm_bo_validate() skip the "current
>> > resource already compatible" short-circuit so a move is forced even when
>> > placement is unchanged. In ttm_bo_handle_move_mem(), when defragging a
>> > populated BO, stash the old tt, create and populate a fresh one
>> > (allocating new backing), and hand the old tt to the driver move
>> > callback via bo->defrag_old_tt for copying. On success the old tt is
>> > unpopulated and freed; if populate or the move fails, the freshly
>> > allocated backing is discharged and the BO is restored to its original
>> > tt and placement.
>> >
>> > The old tt is handed off through bo->defrag_old_tt (reservation-lock
>> > protected) rather than the operation context. The pointer describes BO
>> > state for the duration of the move, so keeping it on the buffer object
>> > is better layering and lets ttm_bo_move_accel_cleanup() pick it up.
>> >
>> > Because a defrag move commonly fails (beneficial-order pages are often
>> > unavailable) and then leaves the BO untouched on its original backing,
>> > defer ttm_bo_unmap_virtual() for the defrag case until the new backing
>> > has been populated and the move is about to commit. Ordinary moves still
>> > unmap up front. This avoids needlessly zapping and refaulting every
>> > userspace mapping on the common failure path where nothing moved.
>> >
>> > Teach ttm_bo_move_accel_cleanup()'s ghost path about defrag: instead of
>> > tearing the move's source tt down synchronously, hand bo->defrag_old_tt
>> > to the ghost object so it is kept populated until the copy fence signals
>> > and then unbound and destroyed asynchronously, while the BO keeps its
>> > new tt. This lets a driver pipeline defrag teardown behind the GPU copy
>> > rather than blocking on it.
>> >
>> > This is driver-opt-in and a no-op unless ctx->defrag is set.
>> >
>> > Cc: Carlos Santa <carlos.santa@intel.com>
>> > Cc: Ryan Neph <ryanneph@google.com>
>> > Cc: Christian Koenig <christian.koenig@amd.com>
>> > Cc: Huang Rui <ray.huang@amd.com>
>> > Cc: Matthew Auld <matthew.auld@intel.com>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: Maxime Ripard <mripard@kernel.org>
>> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > Cc: David Airlie <airlied@gmail.com>
>> > Cc: Simona Vetter <simona@ffwll.ch>
>> > Cc: dri-devel@lists.freedesktop.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> > Assisted-by: GitHub_Copilot:claude-opus-4.8
>> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> >
>> > ---
>> >
>> > v3:
>> > - Reject defrag moves needing a multihop bounce: WARN, restore backing,
>> >   -EINVAL (Sashiko)
>> > ---
>> > drivers/gpu/drm/ttm/ttm_bo.c      | 100 +++++++++++++++++++++++++++---
>> > drivers/gpu/drm/ttm/ttm_bo_util.c |  16 ++++-
>> > drivers/gpu/drm/ttm/ttm_pool.c    |   5 +-
>> > include/drm/ttm/ttm_bo.h          |  17 +++++
>> > 4 files changed, 127 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> > index 3980f376e3ba..c1629b4c4f0f 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> > @@ -125,49 +125,133 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>> > {
>> > 	struct ttm_device *bdev = bo->bdev;
>> > 	bool old_use_tt, new_use_tt;
>> > +	bool defrag;
>> > 	int ret;
>> >
>> > 	old_use_tt = !bo->resource || ttm_manager_type(bdev, bo->resource->mem_type)->use_tt;
>> > 	new_use_tt = ttm_manager_type(bdev, mem->mem_type)->use_tt;
>> >
>> > -	ttm_bo_unmap_virtual(bo);
>> > +	/*
>> > +	 * Only the BO that is the actual defrag target (moved in place via
>> > +	 * ttm_bo_validate(), evict == false) is being defragmented. The same
>> > +	 * ctx->defrag is threaded into evictions triggered while allocating
>> > +	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
>> > +	 * an unrelated victim BO (evict == true) being misclassified as a
>> > +	 * defrag move and needlessly reallocating its backing.
>> > +	 */
>> > +	defrag = ctx->defrag && !evict && new_use_tt && bo->ttm &&
>> > +		 ttm_tt_is_populated(bo->ttm);
>> > +
>>
>> The sashiko reports a bug about '!evict' check which seems legitimate.
>>
>
>See below - we don't allow multi-hop if ctx->defrag == true - i.e., we
>pop a warning if driver tries to do this. Thus the Sashiko feedback
>isn't right.
>

I think the issue is in ttm_bo_evict():

         ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
         if (ret != -EMULTIHOP)
                 break;

         ret = ttm_bo_bounce_temp_buffer(bo, ctx, &hop);

The bo here is an unrelated victim BO being evicted to make room for the defrag target's new backing —
not the BO actually being defragged. ctx is the same ctx threaded down from the defrag target's
ttm_bo_validate() call, so ctx->defrag is still set.

If the first call (evict=true) returns -EMULTIHOP, ttm_bo_bounce_temp_buffer() calls
ttm_bo_handle_move_mem(bo, hop_mem, false, ctx, NULL) — evict=false this time,
with ctx->defrag still true. defrag = ctx->defrag && !evict && ...now evaluates true for
this unrelated victim, misclassifying its bounce-completion as a defrag move.

Since this is the final hop (it's completing the bounce, not requesting another one),
it doesn't return -EMULTIHOP itself, so the WARN_ON_ONCE+EINVAL guard below never triggers
here — that guard only catches a defrag-classified move that itself needs another hop.

>> > +	/*
>> > +	 * Tear down userspace mappings up front for ordinary moves. A defrag
>> > +	 * move is likely to leave the BO in place (beneficial-order allocation
>> > +	 * commonly fails), so defer the unmap until the new backing has been
>> > +	 * populated and the move is about to commit. This avoids a needless
>> > +	 * zap and refault of every userspace mapping on the common failure,
>> > +	 * where the BO keeps its original, still-mapped backing.
>> > +	 */
>> > +	if (!defrag)
>> > +		ttm_bo_unmap_virtual(bo);
>> >
>> > 	/*
>> > 	 * Create and bind a ttm if required.
>> > 	 */
>> >
>> > 	if (new_use_tt) {
>> > +		struct ttm_tt *defrag_old_tt = NULL;
>> > +
>> > +		/*
>> > +		 * For a defrag move, stash the current populated tt and force a
>> > +		 * fresh one to be created and populated (at beneficial order).
>> > +		 * The old tt is handed to the driver move callback to copy the
>> > +		 * contents from, and freed once the move completes.
>> > +		 */
>> > +		if (defrag) {
>> > +			defrag_old_tt = bo->ttm;
>> > +			bo->ttm = NULL;
>> > +		}
>> > +
>> > 		/* Zero init the new TTM structure if the old location should
>> > 		 * have used one as well.
>> > 		 */
>> > -		ret = ttm_tt_create(bo, old_use_tt);
>> > -		if (ret)
>> > +		ret = ttm_tt_create(bo, old_use_tt && !defrag_old_tt);
>> > +		if (ret) {
>> > +			if (defrag_old_tt)
>> > +				bo->ttm = defrag_old_tt;
>> > 			goto out_err;
>> > +		}
>> >
>> > -		if (mem->mem_type != TTM_PL_SYSTEM) {
>> > +		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
>> > 			ret = ttm_bo_populate(bo, ctx);
>> > -			if (ret)
>> > +			if (ret) {
>> > +				/*
>> > +				 * Discharge the freshly allocated backing and
>> > +				 * leave the BO on its original tt/placement.
>> > +				 */
>> > +				if (defrag_old_tt) {
>> > +					ttm_tt_destroy(bo->bdev, bo->ttm);
>> > +					bo->ttm = defrag_old_tt;
>> > +				}
>> > 				goto out_err;
>> > +			}
>> > 		}
>> > +
>> > +		bo->defrag_old_tt = defrag_old_tt;
>> > 	}
>> >
>> > 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
>> > 	if (ret)
>> > 		goto out_err;
>> >
>> > +	/*
>> > +	 * A defrag move deferred its virtual unmap until the new backing was
>> > +	 * successfully populated; tear the userspace mappings down now, before
>> > +	 * the move swaps in the new pages, so the next fault re-establishes
>> > +	 * them against the new backing.
>> > +	 */
>> > +	if (defrag)
>> > +		ttm_bo_unmap_virtual(bo);
>> > +
>>
>> NIT...would it be good to always do virtual unmap here defrag or not?
>>
>
>We could unconditionally move the ttm_bo_unmap_virtual here. I didn't do
>that to not mess non-defrag behavior but it looks harmless to
>unconditionally shuffle around.

yes, ok.

>
>> > 	ret = bdev->funcs->move(bo, evict, ctx, mem, hop);
>>
>> Sashiko reports a bug here when ttm_bo_move_memcpy() is used as move()
>> function. Though xe doesn't use that function, it is perhaps good to
>> guard against.
>>
>
>What is suggestion to guard against this?
>

As ttm_bo_move_memcpy() is not defragmentation aware, it will cause both
source and destination kmap to refer to same bo->ttm. we should probably
guard against drivers falling back on ttm_bo_move_memcpy(). May be in
ttm_bo_move_memcpy(), add a WARN_ON if bo->defrag_old_tt is set and
return error?

>> > 	if (ret) {
>> > -		if (ret == -EMULTIHOP)
>> > +		if (ret == -EMULTIHOP) {
>> > +			/*
>> > +			 * A defrag move targets the BO's current placement and
>> > +			 * must complete in a single hop. A driver requesting a
>> > +			 * bounce here is unsupported: restore the original
>> > +			 * backing and fail the defrag rather than retrying the
>> > +			 * multihop with ctx->defrag still set, which would
>> > +			 * misclassify the bounce as another defrag move and
>> > +			 * overwrite/leak bo->defrag_old_tt.
>> > +			 */
>> > +			if (unlikely(defrag)) {
>
>Here is what makes -EMULTIHOP (Sashiko evict issue) impossible.
>

Responded above.

>> > +				WARN_ON_ONCE(1);
>> > +				ret = -EINVAL;
>> > +				goto out_err;
>> > +			}
>> > 			return ret;
>> > +		}
>> > 		goto out_err;
>> > 	}
>> >
>> > +	if (bo->defrag_old_tt) {
>> > +		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
>> > +		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
>> > +		bo->defrag_old_tt = NULL;
>> > +	}
>> > +
>> > 	ctx->bytes_moved += bo->base.size;
>> > 	return 0;
>> >
>> > out_err:
>> > -	if (!old_use_tt)
>> > +	if (bo->defrag_old_tt) {
>> > +		/* Failed defrag move: restore the original backing. */
>> > +		ttm_bo_tt_destroy(bo);
>> > +		bo->ttm = bo->defrag_old_tt;
>> > +		bo->defrag_old_tt = NULL;
>> > +	} else if (!old_use_tt) {
>>
>> Another sashiko reported bug about tearing down the old pages while an
>> async copy is still in progress. Looks like xe driver waits for move to
>> complete before returning, so should be fine. But probably worth adding
>> a documentation for defrag_old_tt that "a defrag-aware move callback must
>> not return an error while a copy into the new backing is still in flight
>>
>
>I think it is implied in the ->move() contract if one fails after
>triggering an async move, you must wait on async move before returning
>or TTM will explode. This appears to be existing behavior too.
>

Ok.

One more point below.

>Matt
>
>> Niranjana
>>
>> > 		ttm_bo_tt_destroy(bo);
>> > +	}
>> >
>> > 	return ret;
>> > }
>> > @@ -835,7 +919,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
>> > 	force_space = false;
>> > 	do {
>> > 		/* Check whether we need to move buffer. */
>> > -		if (bo->resource &&
>> > +		if (bo->resource && !ctx->defrag &&
>> > 		    ttm_resource_compatible(bo->resource, placement,
>> > 					    force_space))
>> > 			return 0;
>> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> > index 3e3c201a0222..771313162c8d 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> > @@ -626,10 +626,22 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
>> > 	 * bo to be unbound and destroyed.
>> > 	 */
>> >
>> > -	if (dst_use_tt)
>> > +	if (bo->defrag_old_tt) {
>> > +		/*
>> > +		 * Defrag move: @bo already points at the freshly allocated,
>> > +		 * beneficial-order tt that the move copied into. Hand the old
>> > +		 * tt (the move's source) to the ghost so it is kept populated
>> > +		 * until @fence signals and then unbound and destroyed, instead
>> > +		 * of being torn down synchronously. @bo keeps its new tt.
>> > +		 */
>> > +		ghost_obj->ttm = bo->defrag_old_tt;
>> > +		ghost_obj->defrag_old_tt = NULL;
>> > +		bo->defrag_old_tt = NULL;
>> > +	} else if (dst_use_tt) {
>> > 		ghost_obj->ttm = NULL;
>> > -	else
>> > +	} else {
>> > 		bo->ttm = NULL;
>> > +	}
>> >
>> > 	dma_resv_unlock(&ghost_obj->base._resv);
>> > 	ttm_bo_put(ghost_obj);
>> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>> > index 0ca63f5ce73c..d045105afc24 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> > @@ -860,8 +860,11 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
>> > 	 * pages. Record it so the driver can later try to defragment the object
>> > 	 * back to beneficial order.
>> > 	 */
>> > -	if (it->beneficial_order && it->order == it->beneficial_order)
>> > +	if (it->beneficial_order && it->order == it->beneficial_order) {
>> > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>> > +		if (it->ctx->defrag)
>> > +			return -ENOMEM;
>> > +	}
>>
>> NIT...probably good to add a comment here that says something like,
>> 'return error here as the purpose of defragmentation is to get beneficial order'.
>>

I guess, you missed this point (sorry for signing early at previous comment).

Niranjana

>> >
>> > 	it->order--;
>> > 	it->page_caching = it->tt->caching;
>> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>> > index fd814b5cf535..f4f8a8c29f04 100644
>> > --- a/include/drm/ttm/ttm_bo.h
>> > +++ b/include/drm/ttm/ttm_bo.h
>> > @@ -135,6 +135,16 @@ struct ttm_buffer_object {
>> > 	 * reservation lock.
>> > 	 */
>> > 	struct sg_table *sg;
>> > +
>> > +	/**
>> > +	 * @defrag_old_tt: Used internally during a defrag move to hand the BO's
>> > +	 * previous, populated struct ttm_tt to the driver's move callback so
>> > +	 * that it can copy the contents into the freshly allocated
>> > +	 * beneficial-order backing. Set by TTM, consumed by the driver; the old
>> > +	 * tt is freed (or restored on failure) by TTM once the move completes.
>> > +	 * Protected by the reservation lock.
>> > +	 */
>> > +	struct ttm_tt *defrag_old_tt;
>> > };
>> >
>> > #define TTM_BO_MAP_IOMEM_MASK 0x80
>> > @@ -194,6 +204,13 @@ struct ttm_operation_ctx {
>> > 	 * reclaim/compaction before falling back to a smaller order anyway.
>> > 	 */
>> > 	bool beneficial_reclaim_backoff;
>> > +	/**
>> > +	 * @defrag: Defragmentation pass. Attempt a move even when the bo's
>> > +	 * current resource is already compatible with the requested placement,
>> > +	 * so that the backing store can be reallocated at the pool's beneficial
>> > +	 * order.
>> > +	 */
>> > +	bool defrag;
>> > 	/**
>> > 	 * @resv: Reservation object to be used together with
>> > 	 * @allow_res_evict.
>> > --
>> > 2.34.1
>> >
