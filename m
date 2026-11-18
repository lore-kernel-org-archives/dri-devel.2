Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415A606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wzeyv3g3;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OzKfaGsI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE8E10E367;
	Wed, 18 Nov 2026 20:03:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0BD10E367;
 Wed, 18 Nov 2026 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795032194; x=1826568194;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ks2y5nmztwbfwNaFF7LH+lMHuPfZHbJNlQIYXsCWTus=;
 b=Wzeyv3g3IYpl11l0htCglpW1c0Vcv9pBBdt2ceHk7TyTS9d13vRTR5t3
 72xxjumLawRKucSSgSUX1ogALkSqNZ5pEeGuwNhYdkHTo3CLb2ODj6Jec
 BTWLYImXypTIYrMWWf6UeJB8mPdqw4i02U0WijWZufSioVbJ/OX2oQjFR
 Ux01fqdwwfSVr09P0iVOnPxa7cb+3Z9QRZ8+NOe+y6RN1APrDJmfRiKkU
 TvJ/78ZWztXZfPvfCXqswkVID/YkUvFYubgeHx5lpVzuGBM9Jga3jteAw
 foLLRSJWxDHc8Y9EtecUa9TWeYInS/MaLGjWZrudIJmqHQU9/KIoOCctE Q==;
X-CSE-ConnectionGUID: J4wP92myQQqnNTQ1+TbARQ==
X-CSE-MsgGUID: wZbLQMhDTKOqi9+xSMsk1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886258"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3886258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 12:03:14 -0800
X-CSE-ConnectionGUID: Pi3rwVQBSOeewTm/tS76xA==
X-CSE-MsgGUID: d+8Ro1l2QzCne5zkLB70nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10452773"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 12:03:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:03:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 12:03:12 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:03:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enVBdJDtU6uG0YWyTmt5pKCbXvh6D8DF+D84UOgWaNWDW2FF9LPeMKoOd+oMovrenfn5CzRRsed2i3JSGNxgXg6iUc5qf9iqvl23FZ2mg0d6TCQ1Ti4SJKKntOya12NUCZlbrU6vfA+KF3rhE9wAu8cac86dpuNSIiNzhu+nuLACFWMLHX5/Hx3EhERUUZpjD2cGauUUq1fsIgSMTtAIDtpDulvElfYbjYXT0tmNbuctSX8fp/GevsQGxU274u8hON0tC4N8x/k+G0oN9azd/RZSQVMQp13RQZQNiJvwvtWIc4z4kzps+jUIAzfug6CTPqFJJs4MEu85U9KUMrEzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks2y5nmztwbfwNaFF7LH+lMHuPfZHbJNlQIYXsCWTus=;
 b=hBKm6UdQR+zw8qJ7988QeSFRt+e/0dMK4gW26AsM719hiH2BkDO2XNDJZTU3tY3gNS89/iN/xyS5eOUn5hMV3VwfEvxFBZatjUdzvZFxJw/OdU1+VOdmD0NGU+T01dFyeRnuy6dHbLfXcXjK4gS303bw+r/M/2oRE26kiUOMaIErFO/OEX+z6uXcESRq/8FDQnOGIcrOaZuY3rH0iEnOged4GLxGPwmi6/U9V+DoUyHMZnBifl8hOM7jJNK3buG4wc1+ObFfMMoTG+GQnNabGb8B69tP37eAEM84Aeiw3xn5dsuNXLAng5PNQrd23phda+0YszM9IEeqqRYYLp/9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks2y5nmztwbfwNaFF7LH+lMHuPfZHbJNlQIYXsCWTus=;
 b=OzKfaGsIU0AXdiZDuGETRCmOiNyuIUFEHgL75xVof4N88YjSzsSZWkB2TECrMsHWaYT1jVl2GaR6RzMxXrxsB2VNTTiFGThKbtWmgAfk3cT0k2eNKNVNNl07VPAjTPiRk+YugTUFI5ZVYmAaPA9uWWnQ++MwXPWxVsNb1MiT2cs=
Received: from AT6PR11MB072844.namprd11.prod.outlook.com
 (2603:10b6:170:10a::16) by SA3PR11MB235483.namprd11.prod.outlook.com
 (2603:10b6:806:536::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:03:10 +0000
Received: from AT6PR11MB072844.namprd11.prod.outlook.com
 ([fe80::520a:561:ace1:e64b]) by AT6PR11MB072844.namprd11.prod.outlook.com
 ([fe80::520a:561:ace1:e64b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:03:10 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>, "yaolu@kylinos.cn"
 <yaolu@kylinos.cn>, "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Piorkowski, Piotr"
 <piotr.piorkowski@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michal.wajdeczko@intel.com" <michal.wajdeczko@intel.com>
Subject: Re: [PATCH] drm/xe/gt: Abort GT init on LMTT initialization failure
Thread-Topic: [PATCH] drm/xe/gt: Abort GT init on LMTT initialization failure
Thread-Index: AQHddzqTPl6W5hP9kUimJBFag+j7wbc0QTMA
Date: Wed, 18 Nov 2026 20:03:09 +0000
Message-ID: <54d0efa24a49e73880bdc4d6f2786b940f32fdf8.camel@intel.com>
References: <20261118085453.198348-1-yaolu@kylinos.cn>
In-Reply-To: <20261118085453.198348-1-yaolu@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB072844:EE_|SA3PR11MB235483:EE_
x-ms-office365-filtering-correlation-id: 58b5018f-589b-4176-f115-08df45aef82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|921020|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info: atNWHfshqX5RPH6M2OrSZos0ohxjf5lu9uDJCKAJnqYx4xP9nuLIKi72P+q0JEQrhFeMAcqkIJTbCMsxNcG3e1owGbp1MMBXpe2jTY9HGyC4cbZGOIAFuGga5suMFGU2kl0fWJi6+xGJMtFoW/90/H4oA45IYhhidDJ/RPqons8VM9tere8yuw53q7+mJ3wxp85n0Iv0FijWl3fADOzbkTQkZyy3iFLxROSWGABDcfLe62Rz6zeDenoZxxdbvK2bxrZVXG8SZxMD6X3zkmDxJgmcBfQj8SWCoRsIfFkmSfhex/KzDn3/qJleGQJJPiGG8CCwwpCU1mRAJpF81geNOF6CiJ7uld0ZY7MWM309X++QJrjpiGLYc8RodFrWP0ydHPNF6A1zuVdZIF58GGIEOln98IQH+CBvc4bUh873Usnz0PZdQ3V9HM/H+XAyOTS6KDl9vtPln5GhJvric3q2+YXbv2TmnBrU7SCYSGRCsNkMUx7Gr2OZ5PL5mMryjtfpwYgmfHrKYIB32RF71tRvq5XaKbHDKJ2tzk8KbeJEvVPXSmeAa1w5p65fxgxT01mgHM9mXUBXlg1Gvc8kpPGRCTirj/4C7G4Pj8pv67XJYCGu/oQY8QfeTnRFSyQXcx4RBY1MW6LaC/lKGos/JHXTOeXEXVxR2kxmjW1NOISOl3Qim9OHvqyRyRvRL6P1+fug4f9p+nvyaORbZINBRmfmX2UFrWsm5a4GSinw6RC/KAvB7pamVPAJFb2SsUdyzS9K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB072844.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(921020)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVZid3dXM3JhMjRLSDczVmg1ZnBOUFNMWWc5V2k0ZnJVMmpxSmxSZ0pXZTIr?=
 =?utf-8?B?d0Jza2JVeWJlRFJ4emdCS25yK1cxZFp3UCtBVDgyZzNOSG05SkF3WmgvSzBo?=
 =?utf-8?B?dE45VmNkR2Jlb2gwTGlFWnFqTUhjN2s3K2YwcHdISVhwZ1hHSDE3elZhd3dV?=
 =?utf-8?B?c0NtVWprOEpIdDBpbWppZXNYYXZ2b0RVVE5uQ1hYNE9rOHhxL2pYa00vUHhI?=
 =?utf-8?B?UkxTK0haNDhYdlpCRHp4azBJZk5iZEJERlB2MFNuTWY0TnhCcFU1Q3dyOStH?=
 =?utf-8?B?ZDFmV1hTZE53Y2dMQzZ6NThOYlFRckZOTllNV1A5L2h5OE5LODI1VWxGcGJY?=
 =?utf-8?B?VjRLeVhMUk53S2V6a1d5M1p2NlRvRE5BMlF5TG1tcWJtcUVLTm9haU5mc0xu?=
 =?utf-8?B?SUI4MlJBV0Ywc0NHcnlzdTZwNVpvK1BBWEpTSHF0alUrUzd2UWhRYWVxTk1M?=
 =?utf-8?B?aFlKS0U5TjAyazk3WjBtTG1JMDkvTUVkdkQ5cTB0MHFVYy9WZyt5Ym9CaGp4?=
 =?utf-8?B?R21VS1p5bFl2a0hKRlNnQlc1SG9ubTc1MC9Rb29MOXhJQjdwY1R4Q2l1RVNQ?=
 =?utf-8?B?UTZ4MGtrYjJPWmU0a3o4d3V2NGZiVW5adlBGQjFwV0hjYjlqOTlvNU5RcXY1?=
 =?utf-8?B?UzJZVTMwZGtVZVhZY3h3WUMxQmJGMGs4QVc2Z20wc2I4by9OOGRpTFh3L0xj?=
 =?utf-8?B?ZkRpbXhKVDJ3aFNoc1FpR3lMS2lHT09oUHNMUzJiRjJmNERYSjVUTnIzb3Ur?=
 =?utf-8?B?YkQ4ZnJabExZL1NNZ2EyNUp4NWN6MVN3RW4wMXl0S2pkSmJmM3djcU9rdE9C?=
 =?utf-8?B?RityWVZ2b28wMERmbUh2aXFWVXlaMkZmYmZaWHJ6NFVlUURoMFdUcDdWUlM5?=
 =?utf-8?B?UzhBZEZ0Y25OUWVjT3lzeTEwUjUvRDRLOGdJdHVCVlljaTRhdmRLb1krTUpP?=
 =?utf-8?B?ang4RnEyM0dpYzROZEhidHNaMjViNktyU0Z3bHcyZjNGOWdUUTNQSms0anhy?=
 =?utf-8?B?TWtqU0pmQ3VWM2pwRFR4VUtjZGx4UVVaek5CMGxXZjdHTmp3ZDAxNktSYmdZ?=
 =?utf-8?B?a2xJZWEzdG1YaHB0czdzVFpZMlYraS9KU0ZtZkFneXNOWlRoUXMraG1IVnQ1?=
 =?utf-8?B?c1h1Ly81Mnk1Qncvc0RsTkhVMi9FVHg0ajRWWlVwRlFNUlB2TEo2dkp5NTVK?=
 =?utf-8?B?RTBuM0orUkQrdW1pZU42NVZqWG8rc2tST0RIRzRJcUtNaVQwaDVjWXpVT25G?=
 =?utf-8?B?ZmVBWUJDbGMxaXZ2bXU0Umw3d0pzZDdHZ1JQRE10K3VWWVdGV2JOS2EydTVw?=
 =?utf-8?B?L0p6N01kNS9NQkROeitHQlR0UXVwUUFlTkd1cURONXAzK1RMQS92NExrTFVY?=
 =?utf-8?B?dnJ5M29aY3h6MG85Nld2cXFJeG9SaEhsckdkYUFLaHhWRkJPNlNPS2t0cUM1?=
 =?utf-8?B?eXlkLzFpL1llM243STlFNkFRSVhndkZkRXp5Nzk5SUErdjVseFplenZmaTBX?=
 =?utf-8?B?cnNtYUtrelNDZkQ3bDZwdXZrN3JIcy96WmdGY3BBYzRZLy82eXUreW8rcHg2?=
 =?utf-8?B?cGJKOUxjREJMM09kUGdRREkzLy9QSFVla0xOYlpyU3diVncrVWxLRFlIeDdQ?=
 =?utf-8?B?VmNEK2h1NnhWSThRc09MSnBNa21NT2RZQ0FEbkdvWUNoQXBmUVFrMzQzUnFr?=
 =?utf-8?B?NUFvV1FWbHhwdFhmRmhzS3h4UjcvY1BlajFsZUVDSjFTZXRwZm1rdjUzalo3?=
 =?utf-8?B?aVNJUmZ0b0VSMWc4ODlrREJYTUh3S0tyS3VoRXp0WTNmU3RoTFlqcy9ucDRr?=
 =?utf-8?B?K1J6Tm1nSXloOUp0bjdPcjRmT3BhNG9maWVJNzdwZElXV0dnVVd5alpwT3gx?=
 =?utf-8?B?NnJqQVhSK0N1bUxCY2MrK3JHeENDQ0RZanpXTi9IV1dNbENYM3BIemx2L0dz?=
 =?utf-8?B?V3lURmppQS9PcThjVDYvK09nSEV1UExRNDVPbGIyQXZwb1NLaHpiY3NKSmov?=
 =?utf-8?B?VFF3RmNnR1IzazdCeWl3V1dHRzdSb3V1Q0xiSHR1bWFlMG80c3p6bkx3T1I4?=
 =?utf-8?B?MWpabmFvYU9rSUtwSFkzNHdsSHFqdzI4V3k2azRnKzZKZktsMktoTU11TVhM?=
 =?utf-8?B?RDRMNk04QU12OXJhQjVtOUcyM3p4VmsrMXpQT0ZhOXVXdmk0bE56MHNoMTZK?=
 =?utf-8?B?WDlzdHZSS0lybFIyVWtFWm1TelI3a2wyK1hNM3EwV1ZRdlJMbk9sRHJqWkp5?=
 =?utf-8?B?VnZGaU9PMFNFQmdZdVA0VHQ5TThoZ1JGNkF3bHBRcUZCS1pzcnU4cG8rbDQy?=
 =?utf-8?B?Njhad3NySDVkcW1pa3VQc1ZsUWlpejdwRktQc2VJVUNsWkdXR0s1U0szcDA3?=
 =?utf-8?Q?qCfU+vQePH0v1orQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47AF98C7B6F7A40A810ACD82C834859@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HeVGReIUq/V0XpLJLz4a4QZNDBE/ky3lj0jtQ/0z7OynO9TbQAyzg/w3o/8+YuhFhquPiqk8BP6IyYFg0fqPJs83jRqxrmtJBMciYGlHdGjfEZH96BxAAv0XCp/5tWaSxU/U/Mq6SUpKShZcJjnoXFzfcd4kRni2R/4Sc/3zV6PIFH5KuqfHCbn5gAMXHh3KDYqhKPRM7x2dqenw4v3BZ5jQUp3k5y9/r5rY7gEWo5ewU8uDwjJLoY7MCF1psjuep7Tnkq+TSKL4Llciz9tDgeQtDfcfQOURNkL0Hdm6Z6wxMstRzJBHxDLJO9g7P6NlRcL/ZSvdEvl+3CTqXBOErQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB072844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b5018f-589b-4176-f115-08df45aef82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 20:03:09.9822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOaH3oPnYo7GzzfxT3CKzCmkM4J4dHvqZ0oSaGMNnE/nZalsCfLwq1nzQsKSojko2Nu9uIYCWD9DVS2+BVey0mofyMVK61eFt1+4osndFPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB235483
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

T24gV2VkLCAyMDI2LTExLTE4IGF0IDE2OjU0ICswODAwLCB5YW9sdUBreWxpbm9zLmNuIHdyb3Rl
Og0KPiBGcm9tOiBMdSBZYW8gPHlhb2x1QGt5bGlub3MuY24+DQo+IA0KPiB4ZV9sbXR0X2luaXQo
KSBjYW4gZmFpbCwgYnV0IGd0X2luaXRfd2l0aF9ndF9mb3JjZXdha2UoKSBpZ25vcmVzIGl0cw0K
PiByZXR1cm4gdmFsdWUuIE9uIGEgUEYgdGhlIHByb2JlIHRoZW4gY29udGludWVzIHdpdGggYSBo
YWxmLQ0KPiBpbml0aWFsaXplZA0KPiBMTVRUOiBsbXR0LT5wZCBpcyBuZXZlciBzZXQgKGFuZCBs
bXR0LT5vcHMgaXMgY2xlYXJlZCksIHNvDQo+IHhlX2xtdHRfaW5pdF9odygpIHJldHVybnMgZWFy
bHkgYW5kIHRoZSBWRiBsb2NhbCBtZW1vcnkgaXMgbGVmdA0KPiB3aXRob3V0DQo+IGEgdHJhbnNs
YXRpb24gZGlyZWN0b3J5IHdoaWxlIHRoZSBkcml2ZXIgc3RpbGwgcmVwb3J0cyBzdWNjZXNzLg0K
PiANCj4gUmV0dXJuIHRoZSB4ZV9sbXR0X2luaXQoKSBlcnJvciBhbmQgYWJvcnQgR1QgaW5pdCBp
bnN0ZWFkLCBhcw0KPiByZXF1aXJlZA0KPiBieSB0aGUgZG9jdW1lbnRlZCBMTVRUIGNvbnRyYWN0
ICgiQW55IExNVFQgaW5pdGlhbGl6YXRpb24gZmFpbHVyZQ0KPiBzaG91bGQgYmxvY2sgVkZzIGVu
YWJsaW5nIikuDQo+IA0KPiBGaXhlczogYjFkMjA0MDU4MjE4ICgiZHJtL3hlL3BmOiBJbnRyb2R1
Y2UgTG9jYWwgTWVtb3J5IFRyYW5zbGF0aW9uDQo+IFRhYmxlIikNCj4gU2lnbmVkLW9mZi1ieTog
THUgWWFvIDx5YW9sdUBreWxpbm9zLmNuPg0KDQpJJ20gbm90IGFuIGV4cGVydCBpbiB0aGlzIGNv
ZGUsIGJ1dCBpdCBkb2VzIGxvb2sgbGlrZSBpZiB3ZSB0cmllZCB0bw0KYWxsb2NhdGUgbWVtb3J5
IGhlcmUgYW5kIHRoYXQgZmFpbGVkIGZvciBzb21lIHJlYXNvbiwgY2F1c2luZyB0aGUgTE1UVA0K
aW5pdCB0byBmYWlsLCBpdCB3b3VsZCBjYXVzZSBkb3duc3RyZWFtIGlzc3VlcyBsYXRlciBpbiB0
aGUgUEYncyBMTVRUDQptYW5hZ2VtZW50LiBCdXQgdGhlIGNoYW5nZSBhcy1pcyBkb2Vzbid0IHNl
ZW0gbGlrZSB0aGUgcmlnaHQgYXBwcm9hY2gNCmhlcmUgSU1PLiBJIGRvbid0IHRoaW5rIHdlIHdh
bnQgdG8ga2lsbCB0aGUgd2hvbGUgZHJpdmVyIGxvYWQgYmVjYXVzZQ0Kb2YgdGhpcywgaXQgc2Vl
bXMgYmV0dGVyIHRvIGp1c3QgbG9nIHRoZSBlcnJvciBhbmQgbm90IGVudW1lcmF0ZSB0aGUNClZG
cy4NCg0KQnV0IGl0IHdvdWxkIGJlIGdvb2QgdG8gZ2V0IGZlZWRiYWNrIGZyb20gUGlvdHIvU2F0
eWEgaGVyZS4NCg0KVGhhbmtzLA0KU3R1YXJ0DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2d0LmMgfCA0ICsrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV9ndC5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d0LmMNCj4gaW5kZXggMjg2YWVlNTc3NWMw
Li4xMjM5Y2JiN2M4NGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndC5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndC5jDQo+IEBAIC01ODIsMTAgKzU4Miwx
MCBAQCBzdGF0aWMgaW50IGd0X2luaXRfd2l0aF9ndF9mb3JjZXdha2Uoc3RydWN0DQo+IHhlX2d0
ICpndCkNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh4ZV9ndF9pc19tYWluX3R5cGUoZ3Qp
KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0geGVfZ2d0dF9pbml0
KGd0X3RvX3RpbGUoZ3QpLT5tZW0uZ2d0dCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoIWVyciAmJiBJU19TUklPVl9QRihndF90b194ZShndCkpKQ0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IHhlX2xtdHRfaW5pdCgm
Z3RfdG9fdGlsZShndCktDQo+ID5zcmlvdi5wZi5sbXR0KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoZXJyKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKElTX1NSSU9WX1BGKGd0X3RvX3hlKGd0KSkpDQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGVfbG10dF9pbml0KCZndF90b190aWxlKGd0
KS0+c3Jpb3YucGYubG10dCk7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IMKgwqDCoMKg
wqDCoMKgwqAvKiBFbmFibGUgcGVyIGh3IGVuZ2luZSBJUlFzICovDQoNCg==
