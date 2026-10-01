Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D67CCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E9210E34B;
	Thu,  1 Oct 2026 11:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I/Frfi5/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7B010E2A7;
 Thu,  1 Oct 2026 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790854823; x=1822390823;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wcns6zW/G4SjlVpSa0ZVs/t0QQSEFok0nnERFMhdhXM=;
 b=I/Frfi5/9le/V11vrJmoBq7yyzAirtc6FGeuW70a52MfH39ycD8x3FFl
 ieEfnZag7ChPk4KMfWg19aul/QNnEPvulxeTHOHNPcCX+pgl83lulkERH
 /Dh7DvkArQnozIJBjb2VJXWGoRc2avXGTJS+2KfCGkFzdixtpJRCQ/vjk
 NdKEuNEV8C2Zdqar9H+4UuEXQaahp2anI/cb7vm1MIbJ3UU8cBMPeA/sU
 Ur8A57vXAwH48srAQ+ABv8u1FIkOF38iKDnzbooulClIwMDbBXsDe6Swa
 H5kG+gSpf43BF32/SjtsKl3nHMagX2SA7ySjdSZnjuxjrXcL/RWMmbQcm Q==;
X-CSE-ConnectionGUID: ldYF9qvMSUeSBBANVjSoFg==
X-CSE-MsgGUID: cCYn1H6gQciUJX8Xgm6LsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102981859"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102981859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:40:22 -0700
X-CSE-ConnectionGUID: pYACoflDRPmQ8wEfq+6ukw==
X-CSE-MsgGUID: FSDDqdhDRWGjhqhcWqAQig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="274059433"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:40:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:40:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 04:40:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqgY5ypWVxicv6f02BnmeUj6yW2AZAVZFIcyrwCU8s/YKl36EOMnpz8XR5erRcaLD/h2SOGQQLIMcrrWVLcl6WshPVVIU1MDrAUr6INXieDAqdmA8bf0r7V5NRY8YpOMsP2M/I0eyMTD3eQnyJhdxrna5bNuiVqcgGxwB0DH+5U+2LylB8iFkej0bVzjFqwYhkMWBzxYJ6xG91IbcpYGlZas8yM7W7LTuxzRyGaLajBm3xxk5hxmNW7ehl5DhafqBDHvWPYb7kJf1m/H00d/VlVczhsWgl71R05hehz0Rkdcj4IPmC7iFDwXZTza1qgna8QpeGZ7sqqXvSI6L9rXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wcns6zW/G4SjlVpSa0ZVs/t0QQSEFok0nnERFMhdhXM=;
 b=hrkAzP1isB9lqK61/knuXJEGETjUEeUavZDmfYmaiHH9QkFBJ7e/nHm8d9rwGR8yxVk6WK3FIS3XzaHaXvYfCs2wVvfIGhG5wSMuRnWCCuDf0e+nNtj+xoWRJBUKZlRj1HacRnk+nkyJLfX7V47WmVlS1OKPqrRdlQGGNjG/XK26yZfqowKou6vrcMSeAOE+HFLqj1DjF1GFx6TAaly2HF9xvjWtkQwyxXF38nV9EpJXxqeADkXnpri26ZtXfMs43xpXJYt4bKkXKHqN7CfDnpYwTRPLWXEA2ZSX9YVSjIztfDM86Q8i8aVMtEVK/ZDP7QDBD8cmptaioe7iZaBUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) by
 PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Thu, 1 Oct 2026 11:40:15 +0000
Received: from DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb]) by DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 11:40:15 +0000
From: "Manna, Animesh" <animesh.manna@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: RE: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Topic: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Index: AQHdRUGO6vw0288nEUWU5ymzB4DiHrblNeMAgANxE8A=
Date: Thu, 1 Oct 2026 11:40:15 +0000
Message-ID: <DS0PR11MB8049D12FFE9DA040D41FB3BCF98A2@DS0PR11MB8049.namprd11.prod.outlook.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-9-animesh.manna@intel.com>
 <dfc66a1292774129a0277ea75a3be0e49ee52eec.camel@intel.com>
In-Reply-To: <dfc66a1292774129a0277ea75a3be0e49ee52eec.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8049:EE_|PH0PR11MB4869:EE_
x-ms-office365-filtering-correlation-id: e73d4d6f-cf39-4160-c51e-08df1fb0c2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: kkJ8wIGgM1Xtl2wtkBapo9BbjRilj6DZmhwheTYQzyC3BNftrlYZwx2PlIolPiqv9rvANX+L2qG8yq5f78OpiS1hPTiQQ9lsS66P0Gc469Y0uMaIUp2YrBjOX37oHf6OoZhHHSmNI+nZ7sx9AgohHeqCmxhYxzofpqEO+z9ZEr/C3q5Jv1gav+qNr9xSWbfXSRVObvvXW+fO15zJk7pXZGSfu0oj/2iya4f+eboRQPdiW86GiH67e/2/7jZCGrixWK9EoWXwhPXi8SE0VJVO+nYOepoQrS/2j9V+1PPr0XPfLTT4fJHvtLC+cKvLQCdNk+6xqwIKOKFlItkMa8oV1s5ZvcF1B/VhqM0BeStCGHwJTqgSwX35HBXt4kYSvZsNbeRZn2XYmUzlo6Z7q68LDxdEq2CmYvA9CNvVcFxjLZPNCsv6xqy9mBDhxDb0G8k0ICb2K6N9/x9W5KP6zr0ZadsVFuHzrvASwBgb1E3B/zaJoqqyQ5/hGryX8iStNjWUgeTp/2FiM0EACvmRDVxN7VNYSvskei5HopPk1YMYvf09MqbiTmbxpx+a5crZzp4JUOqqEbC4INGTGCvNNx42NYIJhvAwwTtpXOf/9Ziq3E8HjT8lAUuki2yN7lOOvx/ZhCNWz5RhsWyJlgohKvswxlefNO2iMO0HYKX18SqaDib2YIbLy4s6ThFGCr53UjBonZEB9iOlsCb8F4WFz+E0h6hZcOiKGTBCkpCL/W2ZnDA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8049.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm9FTXZJdWdkK2JXeTd2SnRsSVRVQ0ZCWjl4S252b3hoV0lVM3N1TU1DTDI3?=
 =?utf-8?B?N1dMVzVkUzJEeEJTRGk4RW1xNFg4a1VHSll4MG8vTmdNVUVjSVhGcXVWdWdL?=
 =?utf-8?B?dnpLWFV2di9VNXBoS2RWSDFwVUNkc3pYNU5CaEptcS9FUUdWT3V3ZnFzSGc3?=
 =?utf-8?B?Rkd3S2h6d1N3bXZrOEpoN3NQSTJWZUJIK2tuV3N6ZkV5UG5rQ2JHRTJuYk1G?=
 =?utf-8?B?WUgybjVmTUFmR01BZmY5aUVQYThzZE10NXlHbGh0bjFkYzhSRTFKeWpVYW51?=
 =?utf-8?B?YU5LSk90VldpMFpZalJydlFyNldhLzMzY0M3dWl1UDMwWE50bjBudmpKb0RO?=
 =?utf-8?B?aTUvS2lRNldaTGRWUnk4ZjU5cTJxWEh1eWJLU1g2WDFKQ2ptVEFVNklEaWhr?=
 =?utf-8?B?ZXlGNUFWV1NaQ091a0NVQ1ZvSVVsbkNhc1d2Q1oxbHlidktaZVRQWmRqdU9v?=
 =?utf-8?B?eG1DdnB3MkdyK01YT2EyQ3dCVUg2VUxqRHZ4WXI0UDNCWGhZL2RNU2VtZG9T?=
 =?utf-8?B?M1BmNG9lT1ovZjBmb1pyU2grcXQ2SlA0bU80OWF0OWxHSVFlTUVKM2I3U2FY?=
 =?utf-8?B?dUdzTk1qRE1GU2poVGFOTFllSDVxMUpRcWJXWXJSQWpmZWRQWDd6UjJvOUJk?=
 =?utf-8?B?N2JXKzEybElTcHN2UDVIazRYMTJlNjNVNUtiSHFsczI1ME5iZWFtM3Q2clNp?=
 =?utf-8?B?eU1PbHNiTE5GOHlwT25ocnQ0czBIWXo3TzhQRmpjWG5GcURtWUR5bURld2ZU?=
 =?utf-8?B?bVJhKzlQQTJlbzlETWc1V1BrM0loRGFDZ3FQaHdoczNFQVdvbWE3U3hVWVZx?=
 =?utf-8?B?NXFuTzJIa2JQclMrNlZtSjRyeTVDZFdYaGFnTFUvTU12L09CTkNCQjk5Z3pU?=
 =?utf-8?B?VG9EN1I5RVdzNlNwbzY5T0lBS0hnN0tKdzIyZWJpY3RySWk3SldmaUFUMU5t?=
 =?utf-8?B?UGVNRnAvOXRPYjNvaEMrWlNFWVQ4NmFLdk9XTkQweXdiYndyemtPVFlaUExJ?=
 =?utf-8?B?bDF0dlhBaUk2bGNDNUdRRTBXcXZpQmJwM3BjcVZrZnRqSHNyRFhnSXZwU3pB?=
 =?utf-8?B?TVZaTDRONzg1bzJKVGVTZE4rWVh2bWNWeVJVRnBCRnlxekx2dVR1SmNDT2FW?=
 =?utf-8?B?QXdJV1AxK3hCczE0MWNyOXZIVWNXM3g5c3Y2MGYrNVNGZnZRc1Z3MHhiZGl5?=
 =?utf-8?B?ZTJ2bDlzZUkyTFpET2M0WHlzSCt5ZlhCYXdkVmRpdUNMTi9Vbm5uNHIrQ2lj?=
 =?utf-8?B?YjNUZVo0YjRuanNUbXpjMHdWZlE5MkgyMmpQYzdSRFdXOXhtL3pXcU94V095?=
 =?utf-8?B?WHRGZDdDNG52SVRXWWdNVnVYTzd6UGROajd5emRLRTF3d2d4OXFCdGh1R1ox?=
 =?utf-8?B?ZnhLL2I2em1EQU0rbm8zOFI1NHBFa0QyVXk0dndlWG52Z05ONVdUSEdrOUJW?=
 =?utf-8?B?QnVGeExtdnZBUk0zeUpQSUoyWDZkaS90ZmJmYjY1ekFXTVZZNXNhdUlQNTRu?=
 =?utf-8?B?eWNPdmFPZ2NnMlgyaEZFbVFBYml4MktzSWpsQkdaZFhYSEN5U1JPWkh4VHZZ?=
 =?utf-8?B?QkRzV2tQMHJDQ2tiVS9GSzVWQk5ncC92Z2lnVGtkYTZzNHAyYkVQeElPVWUr?=
 =?utf-8?B?VkJleEZSTEdnOVlkbDhNTk5ZRURSVjFtRHArUTl1L1J3OXBxZzRaYzJrdFN0?=
 =?utf-8?B?T3JkUG0vVEJVNzZhV2t1elVOV1hVYVVlSk1uWmFGWjJEWVpCTG91dHVOSmZO?=
 =?utf-8?B?UGpKZFNHaHN6WFRNTkhpblhJOXlaNDg0aDQ4TFFvdzhBRS9oNEx4NVFaSTZx?=
 =?utf-8?B?RjNEZVFYQ083ZXIwbGxsb3VJR3NKdkt6ZzlpKzRxS1ZLSFlBUklqWk9za0ky?=
 =?utf-8?B?WStxSDdtTlhQM28rcGdSUU9Ja3d1akRtSVMwUTJpViswOWN0RlN0YVRPdmNp?=
 =?utf-8?B?RFZTbFlKSjJQYUFzTXZ0QUNVYnI4REVFV2VMWExlSFBvY2ZYTWgySzUybnBV?=
 =?utf-8?B?SnM4NHQzNzJpc2d0cC91WTJJblNWd0M3SlFIdlNmTWJMbFI0NzBrMXRKRHh0?=
 =?utf-8?B?M1NtTkxIT2RCYUozeTE1WUw0eFRzUzVVQWo3UXJkSVhJaHJWM3BMWWs3R0dj?=
 =?utf-8?B?TE9YSThFUk4zamlvZm1jalRTbVRIamFjTnVqRG0zYXVJWjVDaTFNb2srVTJD?=
 =?utf-8?B?alQxQXpQYy9ZaE9ta3ZXdE9sVkJibXFndVgxZWZ6U2dKbHVTcG5QWnBkVnZ5?=
 =?utf-8?B?SnZkSDh3VTd2dlZaUjhOazFMT0RrOEJ6bDcrYUFyNkVTTzJYZ2pIb2VOUC9v?=
 =?utf-8?B?cUZWWmN5YUg1cE5SQStmY251U1NsSUM3eDBXV1hUM2x6d00xZStBY2t2Sm5I?=
 =?utf-8?Q?DcPi51aVG2BwDiuE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cWjalROr+FkHwF3a+HAfvbMiviFmTrpknnUBWYIQAEvrsWGZk10nvmHRtT615vHbi98XQfANV5QGDLbjJ7XSN/QiOXSYaK1ogq8uA7fsOITqZqhkJyTdOtZIze5orZIXvBhYNNwkQafh/fgeyhtjVuw7eXGixFaGP/iYoBHlhPRcJxQcQJ4fD1wEplbx/ujmNLZqLNr5twhgaBjNBIHrqc7IdPBVxgLVXmiiMYM3ZBctxQAcq8gP2qgpLO9+sRJ7CC2ikq6vkS009rJcplI4VLxukynfIc98m1+I9b62gFwLYKf+AxvzqFxCE7ocJE+oghirKV6GvkV/pYM37dAfcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d4d6f-cf39-4160-c51e-08df1fb0c2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 11:40:15.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xWvZAcJ4LXEM+/14F9NWva1VkNIAREzq5jUnvevLhiXeAodGQ0xq87EerVBTnFke1dbhcmmTnMI1wP5ZAIaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9nYW5kZXIsIEpvdW5p
IDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAy
OSwgMjAyNiAxMjozMCBQTQ0KPiBUbzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNYW5uYSwNCj4gQW5pbWVzaCA8YW5pbWVz
aC5tYW5uYUBpbnRlbC5jb20+OyBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBLYW5kcGFsLCBTdXJhaiA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+OyBOaWt1bGEsIEphbmkN
Cj4gPGphbmkubmlrdWxhQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwOC8x
OF0gZHJtL2k5MTUvYWxwbTogdGFibGUgYmFzZWQgZXN0YWJsaXNobWVudA0KPiBwZXJpb2QNCj4g
DQo+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAyMzozNCArMDUzMCwgQW5pbWVzaCBNYW5uYSB3cm90
ZToNCj4gPiBPbmx5IHVzZSB0aGUgdGFibGUgd2hlbiB0aGUgbGluayByYXRlIGlzIGxpc3RlZCAo
aWR4IHZhbGlkKSBhbmQgdGhlDQo+ID4gTFRUUFIgY291bnQgaXMgd2l0aGluIHRoZSB0YWJsZSBi
b3VuZHMuIEEgemVybyBlbnRyeSBtZWFucyB0aGUgcmF0ZQ0KPiA+IGhhcyBubyB0YWJ1bGF0ZWQg
dmFsdWUsIHNvIGZhbGwgYmFjayB0byB0aGUgY29tcHV0ZWQgZXN0YWJsaXNobWVudA0KPiA+IHBl
cmlvZCBiZWxvdy4NCj4gPg0KPiA+IE5vdGU6IFRoZSB0YWJsZSBhbmQgaXRzIHZhbHVlcyBhcmUg
dGFrZW4gZnJvbSBEUDIuMSB2ZXNhIHNwZWMuDQo+ID4NCj4gPiB2MjogQWRkIGNoZWNrIGZvciBu
ZWdhdGl2ZSBlcnJvciBjb2RlcyBmcm9tIGRybV9kcF9sdHRwcl9jb3VudCgpLg0KPiA+IFtzYXNo
aWtvXQ0KPiA+DQo+ID4gQ2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9hbHBtLmMgfCA5NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+IGluZGV4IGRjMDI1MDU4YTYyNi4uY2IyNGJi
YTgwMWExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmMNCj4gPiBAQCAtMTIyLDYgKzEyMiw5MiBAQCBzdGF0aWMgaW50IGdldF9kcF9saW5rX3N5
bWJvbF9zaXplKGNvbnN0IHN0cnVjdA0KPiA+IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUp
DQo+ID4gwqAJcmV0dXJuIGludGVsX2RwX2lzX3VoYnIoY3J0Y19zdGF0ZSkgPyAzMiA6IDEwOw0K
PiA+IMKgfQ0KPiA+DQo+ID4gKyNkZWZpbmUgREVGQVVMVF9NQVhfTFRUUFJfQ09VTlQgNw0KPiA+
ICsjZGVmaW5lIE1BWF9TVVBQT1JURURfRFBfTElOS19SQVRFUyAxMg0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHUzMg0KPiA+DQo+IGVzdGFibGlzaG1lbnRfcGVyaW9kc1tERUZBVUxUX01BWF9M
VFRQUl9DT1VOVF1bTUFYX1NVUFBPUlRFRF9EDQo+IFBfTElOS18NCj4gPiBSQVRFU10gPSB7DQo+
ID4gKwkvKiAxNjIwLCAyMTYwLCAyNDMwLCAyNzAwLCAzMjQwLCA0MzIwLCA1NDAwLCA2NzUwLCA4
MTAwLA0KPiA+IDEwMDAwLCAxMzUwMCwgMjAwMDAgKi8NCj4gPiArCS8qIE5vIFJldGltZXJzICov
DQo+ID4gKwl7IDYxMDcwLCAwLCAwLCA1NjcxMCwgMCwgMCwgNTM0NTAsIDAsIDUyMzYwLCA1OTA1
MCwgNTY3NTAsDQo+ID4gNTQ2MjAgfSwNCj4gPiArCS8qwqAgMSBSZXRpbWVywqAgKi8NCj4gPiAr
CXsgMTU1NjcwLCAwLCAwLCAxNTEzMTAsIDAsIDAsIDE0ODA1MCwgMCwgMTQ2OTYwLCAxNTM2NTAs
DQo+ID4gMTUxMzUwLCAxNDkyMjAgfSwNCj4gPiArCS8qwqAgMiBSZXRpbWVycyAqLw0KPiA+ICsJ
eyAxODExNjAsIDAsIDAsIDE3MjQ1MCwgMCwgMCwgMTY1OTEwLCAwLCAxNjM3NDAsIDE3NzEyMCwN
Cj4gPiAxNzI1MjAsIDE2ODIyMCB9LA0KPiA+ICsJLyrCoCAzIFJldGltZXJzICovDQo+ID4gKwl7
IDIwNjY1MCwgMCwgMCwgMTkzNTgwLCAwLCAwLCAxODM3ODAsIDAsIDE4MDUxMCwgMjAwNTkwLA0K
PiA+IDE5MzY5MCwgMTg3MjkwIH0sDQo+ID4gKwkvKsKgIDQgUmV0aW1lcnMgKi8NCj4gPiArCXsg
MjMyMTQwLCAwLCAwLCAyMTQ3MTAsIDAsIDAsIDIwMTY1MCwgMCwgMTk3MjkwLCAyMjQwNjAsDQo+
ID4gMjE0ODYwLCAyMDYzMjAgfSwNCj4gPiArCS8qwqAgNSBSZXRpbWVycyAqLw0KPiA+ICsJeyAy
NTc2MjAsIDAsIDAsIDIzNTg1MCwgMCwgMCwgMjE5NTEwLCAwLCAyMTQwNzAsIDI0NzUzMCwNCj4g
PiAyMzYwMzAsIDIyNTM2MCB9LA0KPiA+ICsJLyrCoCA2IFJldGltZXJzICovDQo+ID4gKwl7IDI4
MzExMCwgMCwgMCwgMjU2OTgwLCAwLCAwLCAyMzczODAsIDAsIDIzMDg1MCwgMjcxMDAwLA0KPiA+
IDI1NzIwMCwgMjQ0MzkwIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtlbnVtIGxpbmtfcmF0ZV9p
ZHggew0KPiA+ICsJTElOS19SQVRFX0lOVkFMSUQgPSAtMSwNCj4gPiArCUxJTktfUkFURV8xLA0K
PiA+ICsJTElOS19SQVRFXzIsDQo+ID4gKwlMSU5LX1JBVEVfMywNCj4gPiArCUxJTktfUkFURV80
LA0KPiA+ICsJTElOS19SQVRFXzUsDQo+ID4gKwlMSU5LX1JBVEVfNiwNCj4gPiArCUxJTktfUkFU
RV83LA0KPiA+ICsJTElOS19SQVRFXzgsDQo+ID4gKwlMSU5LX1JBVEVfOSwNCj4gPiArCUxJTktf
UkFURV8xMCwNCj4gPiArCUxJTktfUkFURV8xMSwNCj4gPiArCUxJTktfUkFURV8xMg0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBnZXRfbGlua19yYXRlX2luZGV4KGludCBwb3J0X2Ns
b2NrKSB7DQo+ID4gKwlpbnQgbGlua19yYXRlX2luZGV4Ow0KPiA+ICsNCj4gPiArCXN3aXRjaCAo
cG9ydF9jbG9jaykgew0KPiA+ICsJY2FzZSAxNjIwMDA6DQo+ID4gKwkJbGlua19yYXRlX2luZGV4
ID0gTElOS19SQVRFXzE7CS8vIFJhdGVfMSAoUkJSKSAtDQo+ID4gMS42MiBHYnBzL0xhbmUNCj4g
PiArCQlicmVhazsNCj4gPiArCWNhc2UgMjE2MDAwOg0KPiA+ICsJCWxpbmtfcmF0ZV9pbmRleCA9
IExJTktfUkFURV8yOwkvLyBSYXRlXzLCoMKgwqDCoMKgwqAgLQ0KPiA+IDIuMTYgR2Jwcy9MYW5l
DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDI0MzAwMDoNCj4gPiArCQlsaW5rX3JhdGVfaW5k
ZXggPSBMSU5LX1JBVEVfMzsJLy8gUmF0ZV8zwqDCoMKgwqDCoMKgIC0NCj4gPiAyLjQzIEdicHMv
TGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAyNzAwMDA6DQo+ID4gKwkJbGlua19yYXRl
X2luZGV4ID0gTElOS19SQVRFXzQ7CS8vIFJhdGVfNCAoSEJSKSAtDQo+ID4gMi43MCBHYnBzL0xh
bmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMzI0MDAwOg0KPiA+ICsJCWxpbmtfcmF0ZV9p
bmRleCA9IExJTktfUkFURV81OwkvLyBSYXRlXzUgKFJCUjIpLQ0KPiA+IDMuMjQgR2Jwcy9MYW5l
DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDQzMjAwMDoNCj4gPiArCQlsaW5rX3JhdGVfaW5k
ZXggPSBMSU5LX1JBVEVfNjsJLy8gUmF0ZV82wqDCoMKgwqDCoMKgIC0NCj4gPiA0LjMyIEdicHMv
TGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSA1NDAwMDA6DQo+ID4gKwkJbGlua19yYXRl
X2luZGV4ID0gTElOS19SQVRFXzc7CS8vIFJhdGVfNyAoSEJSMiktDQo+ID4gNS40MCBHYnBzL0xh
bmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgNjc1MDAwOg0KPiA+ICsJCWxpbmtfcmF0ZV9p
bmRleCA9IExJTktfUkFURV84OwkvLyBSYXRlXzjCoMKgwqDCoMKgwqAgLQ0KPiA+IDYuNzUgR2Jw
cy9MYW5lDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDgxMDAwMDoNCj4gPiArCQlsaW5rX3Jh
dGVfaW5kZXggPSBMSU5LX1JBVEVfOTsJLy8gUmF0ZV85IChIQlIzKS0NCj4gPiA4LjEwIEdicHMv
TGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAxMDAwMDAwOg0KPiA+ICsJCWxpbmtfcmF0
ZV9pbmRleCA9IExJTktfUkFURV8xMDsJLy8gUmF0ZV8xMA0KPiA+IChVSEJSMTApIC0gMTAuMCBH
YnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMTM1MDAwMDoNCj4gPiArCQlsaW5r
X3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfMTE7CS8vIFJhdGVfMTENCj4gPiAoVUhCUjEzLjUpIC0g
MTMuNSBHYnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMjAwMDAwMDoNCj4gPiAr
CQlsaW5rX3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfMTI7CS8vIFJhdGVfMTINCj4gPiAoVUhCUjIw
KSAtIDIwLjAgR2Jwcy9MYW5lDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJ
CWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV9JTlZBTElEOw0KPiA+ICsJCWJyZWFrOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBsaW5rX3JhdGVfaW5kZXg7DQo+ID4gK30NCj4gDQo+
IERpZmZlcmVuY2UgYmV0d2VlbiB3aGF0IHRoaXMgdGFibGUgaXMgZ2l2aW5nIHVzIGFuZCB3aGF0
IHdlIGFyZSBnZXR0aW5nIGZyb20NCj4gdGhlIGZvcm11bGEgaXMgY29taW5nIGZyb20gU0lMRU5D
RV9QRVJJT0RfVElNRSBhbmQgdGxmcHNfcGVyaW9kLg0KPiBJbiBEUCBzcGVjIHRoZXkgYXJlIHVz
aW5nIG1heCB2YWx1ZXMgd2hpbGUgb3VyIGNhbGN1bGF0aW9uIGlzIHVzaW5nIG1pZHBvaW50Lg0K
PiANCj4gSSB0aGluayB3ZSBjb3VsZCBqdXN0IHN3aXRjaCB0byBtYXggdmFsdWVzIG9uIHRoZXNl
IGFuZCBkcm9wIGFkZGluZyB0YWJsZXMNCj4gY29tcGxldGVseS4NCg0KQXMgcGVyIEkga25vdyB0
aGUgZm9ybXVsYS1iYXNlZCBhcHByb2FjaCB3aXRoIG1heCB2YWx1ZXMgYWxzbyBsaXR0bGUgc2hv
cnQgZnJvbSB0aGUgdmFsdWVzIGNvbWluZyBmcm9tIFZlc2Egc3BlYy4gVGhpcyBpcyBmb3VuZCBs
aXR0bGUgc2Vuc2l0aXZlIGR1cmluZyBBTFBNIHRlc3Rpbmcgb24gc3BlY2lmaWMgdGVzdCBzZXR1
cCBhbmQgcmVzdWx0aW5nIGZsaXAtZG9uZSB0aW1lb3V0LiBUbyBvdmVyY29tZSB0aGUgaXNzdWUg
Y3VycmVudGx5IHByZWZlciB0byBkaXJlY3QgdmFsdWVzIGZyb20gdmVzYSBzcGVjLiBBbmQgaWYg
bm90IHByZXNlbnQgd2lsbCBmYWxsYmFjayB0byBmb3JtdWxhIGJhc2VkIGFwcHJvYWNoLg0KDQpS
ZWdhcmRzLA0KQW5pbWVzaA0KDQoNCg0KPiANCj4gQlIsDQo+IEpvdW5pIEjDtmdhbmRlcg0KPiAN
Cj4gPiArDQo+ID4gwqBzdGF0aWMgaW50IGdldF9lc3RhYmxpc2htZW50X3BlcmlvZChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwLA0KPiA+IMKgCQkJCcKgwqDCoCBjb25zdCBzdHJ1Y3QgaW50ZWxf
Y3J0Y19zdGF0ZQ0KPiA+ICpjcnRjX3N0YXRlKQ0KPiA+IMKgew0KPiA+IEBAIC0xMzgsOCArMjI0
LDE3IEBAIHN0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9kKHN0cnVjdA0KPiA+IGlu
dGVsX2RwICppbnRlbF9kcCwNCj4gPiDCoAlpZiAoaW50ZWxfY3J0Y19oYXNfdHlwZShjcnRjX3N0
YXRlLCBJTlRFTF9PVVRQVVRfRURQKSkgew0KPiA+IMKgCQl0Y2RzID0gKDcgKyBESVZfUk9VTkRf
VVAoNjUwMCwgdG1sX3BoeV9sb2NrKSArIDEpICoNCj4gdG1sX3BoeV9sb2NrOw0KPiA+IMKgCX0g
ZWxzZSB7DQo+ID4gKwkJaW50IGlkeCA9IGdldF9saW5rX3JhdGVfaW5kZXgoY3J0Y19zdGF0ZS0N
Cj4gPiA+cG9ydF9jbG9jayk7DQo+ID4gKw0KPiA+IMKgCQl0Y2RzID0gNyAqIHRtbF9waHlfbG9j
azsNCj4gPiDCoAkJbHR0cHJfY291bnQgPSBkcm1fZHBfbHR0cHJfY291bnQoaW50ZWxfZHAtDQo+
ID4gPmx0dHByX2NvbW1vbl9jYXBzKTsNCj4gPiArDQo+ID4gKwkJaWYgKGlkeCAhPSBMSU5LX1JB
VEVfSU5WQUxJRCAmJiBsdHRwcl9jb3VudCA+PSAwICYmDQo+ID4gKwkJwqDCoMKgIGx0dHByX2Nv
dW50IDwgREVGQVVMVF9NQVhfTFRUUFJfQ09VTlQgJiYNCj4gPiArCQnCoMKgwqAgZXN0YWJsaXNo
bWVudF9wZXJpb2RzW2x0dHByX2NvdW50XVtpZHhdKSB7DQo+ID4gKwkJCWVzdGFibGlzaG1lbnRf
cGVyaW9kID0NCj4gPiBlc3RhYmxpc2htZW50X3BlcmlvZHNbbHR0cHJfY291bnRdW2lkeF07DQo+
ID4gKwkJCXJldHVybiBlc3RhYmxpc2htZW50X3BlcmlvZDsNCj4gPiArCQl9DQo+ID4gwqAJfQ0K
PiA+DQo+ID4gwqAJaWYgKGx0dHByX2NvdW50ID4gMCkgew0KDQo=
